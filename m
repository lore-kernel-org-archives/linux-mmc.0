From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH 27/38] mmc: sdhci-of-esdhc: remove
	platform_suspend/platform_resume callbacks
Date: Thu, 24 Apr 2014 13:27:14 +0100
Message-ID: <20140424122714.GR26756@n2100.arm.linux.org.uk>
References: <20140423185534.GA26756@n2100.arm.linux.org.uk> <E1Wd2Wy-0003w6-9y@rmk-PC.arm.linux.org.uk> <CAPDyKFrNpxFPfKQNWZ9iwzh=NKZpCzkA8gYnrqnPb-683QcgwA@mail.gmail.com> <20140424111825.GQ26756@n2100.arm.linux.org.uk> <CAPDyKFpXn7m4+gqBp+FVaUxA3xaGq7OJS3edPFTL015W03CdBA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from gw-1.arm.linux.org.uk ([78.32.30.217]:47997 "EHLO
	pandora.arm.linux.org.uk" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1753298AbaDXM2G (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 24 Apr 2014 08:28:06 -0400
Content-Disposition: inline
In-Reply-To: <CAPDyKFpXn7m4+gqBp+FVaUxA3xaGq7OJS3edPFTL015W03CdBA@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Chris Ball <chris@printf.net>, linux-mmc <linux-mmc@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On Thu, Apr 24, 2014 at 01:32:02PM +0200, Ulf Hansson wrote:
> On 24 April 2014 13:18, Russell King - ARM Linux <linux@arm.linux.org.uk> wrote:
> > That may be the case, but that would be an additional modification, and so
> > should be a separate patch.
> 
> I just thought it make sense to include it here - it's really a simple
> fix, touching the same code as this patch.
> 
> Additionally, it would simplify this patch since you would be able to
> use the PM macro.

No, I'm not going to make this change after looking deeper at the existing
code.

The existing code does this:

sdhci-pltfm.c:
#ifdef CONFIG_PM
int sdhci_pltfm_suspend(struct device *dev)
{
        struct sdhci_host *host = dev_get_drvdata(dev);

        return sdhci_suspend_host(host);
}
EXPORT_SYMBOL_GPL(sdhci_pltfm_suspend);

int sdhci_pltfm_resume(struct device *dev)
{
        struct sdhci_host *host = dev_get_drvdata(dev);

        return sdhci_resume_host(host);
}
EXPORT_SYMBOL_GPL(sdhci_pltfm_resume);

const struct dev_pm_ops sdhci_pltfm_pmops = {
        .suspend        = sdhci_pltfm_suspend,
        .resume         = sdhci_pltfm_resume,
};
EXPORT_SYMBOL_GPL(sdhci_pltfm_pmops);
#endif  /* CONFIG_PM */

sdhci-pltfm.h:
#ifdef CONFIG_PM
extern int sdhci_pltfm_suspend(struct device *dev);
extern int sdhci_pltfm_resume(struct device *dev);
extern const struct dev_pm_ops sdhci_pltfm_pmops;
#define SDHCI_PLTFM_PMOPS (&sdhci_pltfm_pmops)
#else
#define SDHCI_PLTFM_PMOPS NULL
#endif

sdhci-of-esdhc.c:
static struct platform_driver sdhci_esdhc_driver = {
        .driver = {
                .pm = SDHCI_PLTFM_PMOPS,

Changing this to use SIMPLE_DEV_PM_OPS changes the behaviour of this by
placing the callbacks into the other methods.

Is that change correct?
Who's going to test that that change doesn't break anything (I don't have
the hardware, and it's not a transformational change like the rest of the
patch set, but a functional change)?
Should this change be made for other SDHCI platforms as well?

Frankly, I'm not happy to make such a change in a series which is supposed
to be mainly about cleaning up and _not_ introducing functional changes.

-- 
FTTC broadband for 0.8mile line: now at 9.7Mbps down 460kbps up... slowly
improving, and getting towards what was expected from it.
