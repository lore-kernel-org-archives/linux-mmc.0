From: Peter Griffin <peter.griffin-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 1/8] mmc: sdhci-st: Intial support for ST SDHCI controller
Date: Wed, 4 Jun 2014 09:37:27 +0100
Message-ID: <20140604083727.GA23469@griffinp-ThinkPad-X1-Carbon-2nd>
References: <1400771902-26553-1-git-send-email-peter.griffin@linaro.org>
 <1400771902-26553-2-git-send-email-peter.griffin@linaro.org>
 <537EE84C.2020607@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <537EE84C.2020607-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Srinivas Kandagatla <srinivas.kandagatla-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, maxime.coquelin-qxv4g6HH51o@public.gmane.org, patrice.chotard-qxv4g6HH51o@public.gmane.org, srinivas.kandagatla-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, chris-OsFVWbfNK3isTnJN9+BGXg@public.gmane.org, ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, kernel-F5mvAk5X5gdBDgjK7y7TUQ@public.gmane.org, linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Giuseppe Cavallaro <peppe.cavallaro-qxv4g6HH51o@public.gmane.org>, lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org
List-Id: linux-mmc@vger.kernel.org

Hi Srini,

Thanks for reviewing, see my comments below: -

On Fri, 23 May 2014, Srinivas Kandagatla wrote:

> >+struct st_mmc_platform_data {
> >+	struct  reset_control	*rstc;
> >+};
> 
> st_mmc_platform_data name is bit missleading as this data is not
> part of platform data. Probably you could rename it to struct
> sdhci_st_data.

I've now removed this reset controller code for v2, as based on Maxime's feedback
I think this would be better off going in the generic code, so all 
platforms could benefit if they have a reset controller implementation.

I plan to send some RFC patches which implement this seperately to this series.

> >+	pltfm_host->priv = pdata;
> >+
> >+	platform_set_drvdata(pdev, host);
> 
> Why not platform_set_drvdata(pdev, priv_host);
> As you are not using sdhci_host directly, this will reduced few
> indirections in the driver.

Your right, and I was going to change this, but with the re-think on the reset
controller code above I will now need sdhci_host so would prefer to leave it as
is for now.

> >+err_out:
> >+	clk_disable_unprepare(clk);
> >+	sdhci_pltfm_free(pdev);
> >+
> IP could be left out of reset in this path.

Good spot, I'll remember this when I add the reset code
back in :-)

> 
> replace:
> [...
> >+static SIMPLE_DEV_PM_OPS(sdhci_st_pmops, sdhci_st_suspend, sdhci_st_resume);
> >+#define SDHCI_ST_PMOPS (&sdhci_st_pmops)
> >+#else
> >+#define SDHCI_ST_PMOPS NULL
> >+#endif
> ...]
> 
> with :
> 
> #endif
> 
> static SIMPLE_DEV_PM_OPS(sdhci_st_pmops, sdhci_st_suspend, sdhci_st_resume);

Fixed in v2

regards,

Peter.
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
