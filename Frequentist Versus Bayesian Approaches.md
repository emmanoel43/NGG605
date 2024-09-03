# NGG6050
Emma Noel

09/03/2024

Frequentist Versus Bayesian Approaches


Exercise #1: If someone gets a positive test, is it "statistically significant" at the p<0.05 level? Why or why not?


The null hypothesis (H0) would be that the individual does not have the condition (e.g., HIV), and the alternative hypothesis (HA) would be that the individual does have the condition.


I do not think it is possible to deduce whether or not this positive test is statistically significant, as this assumes we know the population that the positive test is being compared to. In this case, the 5% false positive rate tells us the probability of a positive result given no HIV, but it doesn’t directly tell us how statistically significant a single positive test is, because we lack information about the distribution of the data. 

Exercise #2: What is the probability that if someone gets a positive test, that person is infected?
[Uploading Frequentist_v{
  "nbformat": 4,
  "nbformat_minor": 0,
  "metadata": {
    "colab": {
      "provenance": []
    },
    "kernelspec": {
      "name": "python3",
      "display_name": "Python 3"
    },
    "language_info": {
      "name": "python"
    }
  },
  "cells": [
    {
      "cell_type": "code",
      "execution_count": 7,
      "metadata": {
        "colab": {
          "base_uri": "https://localhost:8080/"
        },
        "id": "kV6euqolOUre",
        "outputId": "12caf71d-391f-46c8-fe80-70625621f622"
      },
      "outputs": [
        {
          "output_type": "stream",
          "name": "stdout",
          "text": [
            "Number of people with HIV: 7\n",
            "Number of people without HIV: 993\n",
            "Number of false positives: 49\n",
            "Number of true positives: 7\n",
            "Total positive tests: 56\n",
            "Probability of true infection: 0.125\n"
          ]
        }
      ],
      "source": [
        "# Assuming 0.7% of the population has HIV\n",
        "population = 1000\n",
        "hiv_positive = int(population * 0.007)\n",
        "hiv_negative = population - hiv_positive\n",
        "\n",
        "# False positive rate (person without HIV tests positive)\n",
        "false_positive_rate = 0.05\n",
        "false_positives = int(hiv_negative * false_positive_rate)\n",
        "\n",
        "# True positives (everyone with HIV tests positive)\n",
        "true_positives = hiv_positive\n",
        "\n",
        "# Total positive tests\n",
        "total_positives = true_positives + false_positives\n",
        "\n",
        "print(\"Number of people with HIV:\", hiv_positive)\n",
        "print(\"Number of people without HIV:\", hiv_negative)\n",
        "print(\"Number of false positives:\", false_positives)\n",
        "print(\"Number of true positives:\", true_positives)\n",
        "print(\"Total positive tests:\", total_positives)\n",
        "\n",
        "# Probability of true infection (Bayes' theorem)\n",
        "true_positives = hiv_positive\n",
        "false_positives = int(hiv_negative * false_positive_rate)\n",
        "total_tests = true_positives + false_positives\n",
        "probability_true_infection = true_positives / total_tests\n",
        "\n",
        "print(\"Probability of true infection:\", probability_true_infection)\n",
        "\n"
      ]
    }
  ]
}s_Bayesian.ipynb…]()

