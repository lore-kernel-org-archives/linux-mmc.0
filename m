From: Bjorn Andersson <bjorn@kryo.se>
Subject: Re: [PATCH] mmc: sdhci-msm: Add support for vendor capabilities registers
Date: Thu, 19 Mar 2015 08:36:28 -0700
Message-ID: <CAJAp7Oj9XMHcbsMGfTCUWoi5tGi=eR2AxG_0Bkn4tzAiks89xg@mail.gmail.com>
References: <1426769720-18657-1-git-send-email-georgi.djakov@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <1426769720-18657-1-git-send-email-georgi.djakov@linaro.org>
Sender: linux-arm-msm-owner@vger.kernel.org
To: Georgi Djakov <georgi.djakov@linaro.org>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-arm-msm <linux-arm-msm@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

On Thu, Mar 19, 2015 at 5:55 AM, Georgi Djakov <georgi.djakov@linaro.org> wrote:
[..]

> @@ -516,6 +527,22 @@ static int sdhci_msm_probe(struct platform_device *pdev)
>                 host_version, ((host_version & SDHCI_VENDOR_VER_MASK) >>
>                                SDHCI_VENDOR_VER_SHIFT));
>
> +       core_version = readl_relaxed(msm_host->core_mem + CORE_MCI_VERSION);
> +       core_major = (core_version & CORE_VERSION_MAJOR_MASK) >>
> +                     CORE_VERSION_MAJOR_SHIFT;
> +       core_minor = core_version & CORE_VERSION_MINOR_MASK;
> +       dev_dbg(&pdev->dev, "MCI Version: 0x%08x, major: 0x%04x, minor: 0x%02x\n",
> +               core_version, core_major, core_minor);
> +
> +       /*
> +        * Support for 3v and 8bit bus-width is not advertised by some
> +        * controller versions and must be explicitly enabled.
> +        */
> +       if (core_major >= 1 && core_minor != 0x11 && core_minor != 0x12)
> +               writel_relaxed(readl_relaxed(host->ioaddr + SDHCI_CAPABILITIES)
> +                              | CORE_3_0V_SUPPORT | CORE_8_BIT_SUPPORT,
> +                              host->ioaddr + CORE_VENDOR_SPEC_CAPABILITIES0);

Please split this into read, modify, write statements and put braces around it.

> +

Does the 8916 board you have work without bumping the
regulator_set_load() (previously regulator_set_optimum_mode())? None
of my 8974 boards work reliably without it.

Regards,
Bjorn
