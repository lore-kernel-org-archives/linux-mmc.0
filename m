From: Bjorn Andersson <bjorn@kryo.se>
Subject: Re: [PATCH v6 2/2] mmc: sdhci-msm: Initial support for MSM chipsets
Date: Sat, 5 Oct 2013 22:51:32 -0700
Message-ID: <CAJAp7OjvU2mi_TDiA5d-ut-Q9fHvKSbW_LfdpQGSTprsyPDU0g@mail.gmail.com>
References: <1380301041-26405-1-git-send-email-gdjakov@mm-sol.com>
	<1380301041-26405-3-git-send-email-gdjakov@mm-sol.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <1380301041-26405-3-git-send-email-gdjakov@mm-sol.com>
Sender: linux-doc-owner@vger.kernel.org
To: Georgi Djakov <gdjakov@mm-sol.com>
Cc: linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>, Grant Likely <grant.likely@linaro.org>, Rob Herring <rob.herring@calxeda.com>, devicetree@vger.kernel.org, mark.rutland@arm.com, swarren@wwwdotorg.org, ian.campbell@citrix.com, rob@landley.net, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, Asutosh Das <asutoshd@codeaurora.org>, Venkat Gopalakrishnan <venkatg@codeaurora.org>, Sahitya Tummala <stummala@codeaurora.org>, Subhash Jadavani <subhashj@codeaurora.org>
List-Id: linux-mmc@vger.kernel.org

Hi Georgi,

Thanks for working on this, unfortunately it seems like I need to port
the rpm regulators to be able to test this.
But I did find that...

On Fri, Sep 27, 2013 at 9:57 AM, Georgi Djakov <gdjakov@mm-sol.com> wrote:
> ...
> +static irqreturn_t sdhci_msm_pwr_irq(int irq, void *data)
> +{
> +       struct sdhci_msm_host *msm_host = (struct sdhci_msm_host *)data;
> ...
> +static int sdhci_msm_probe(struct platform_device *pdev)
> +{
> +       struct sdhci_host *host;
> +       struct sdhci_msm_host *msm_host;
> ...
> +       ret = devm_request_threaded_irq(&pdev->dev, msm_host->pwr_irq, NULL,
> +                                       sdhci_msm_pwr_irq, IRQF_ONESHOT,
> +                                       dev_name(&pdev->dev), host);
> ...

...sdhci_msm_pwr_irq() expects the data pointer to be msm_host, not
sdhci_host, so right now I only get a panic. So I suspect you mean
msm_host as the last param here.

Regards,
Bjorn
