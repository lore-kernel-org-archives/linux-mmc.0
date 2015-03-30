From: Peter Griffin <peter.griffin@linaro.org>
Subject: Re: [PATCH v2 5/8] mmc: sdhci-st: Add sdhci_st_set_uhs_signaling
 function.
Date: Mon, 30 Mar 2015 11:46:39 +0100
Message-ID: <20150330104639.GC21893@griffinp-ThinkPad-X1-Carbon-2nd>
References: <1424956227-18258-1-git-send-email-peter.griffin@linaro.org>
 <1424956227-18258-6-git-send-email-peter.griffin@linaro.org>
 <54F59362.40605@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <54F59362.40605@st.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Maxime Coquelin <maxime.coquelin@st.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, patrice.chotard@st.com, srinivas.kandagatla@gmail.com, chris@printf.net, ulf.hansson@linaro.org, lee.jones@linaro.org, devicetree@vger.kernel.org, linux-mmc@vger.kernel.org, peppe.cavallaro@st.com
List-Id: linux-mmc@vger.kernel.org

Hi Maxime,

On Tue, 03 Mar 2015, Maxime Coquelin wrote:
> 
> On 02/26/2015 02:10 PM, Peter Griffin wrote:
> >To allow UHS modes to work properly we need to provide the st specific
> >set_uhs_signaling callback function. This function differs from the
> >generic sdhci_set_uhs_signaling callback in that we need to configure
> >the correct delay depending on the UHS mode, and also set the V18_EN
> >bit.
<snip>
> >+	if (ret)
> >+		dev_warn(mmc_dev(host->mmc), "Error setting dll for clock\n");
> Maybe you could  print the uhs value to know which mode it was
> trying to set?

Yes good idea, I have made that change in v3.
> >+
> >+	dev_dbg(mmc_dev(host->mmc), "uhs %d, ctrl_2 %04X\n", uhs, ctrl_2);
> >+
> >+	sdhci_writew(host, ctrl_2, SDHCI_HOST_CONTROL2);
> >+}
> >  static u32 sdhci_st_readl(struct sdhci_host *host, int reg)
> >  {
> >@@ -283,6 +332,7 @@ static const struct sdhci_ops sdhci_st_ops = {
> >  	.set_bus_width = sdhci_set_bus_width,
> >  	.read_l = sdhci_st_readl,
> >  	.reset = sdhci_reset,
> >+	.set_uhs_signaling = sdhci_st_set_uhs_signaling,
> >  };
> >  static const struct sdhci_pltfm_data sdhci_st_pdata = {
> 
> Other than that, you can add my:
> Acked-by: Maxime Coquelin <maxime.coquelin@st.com>

Thanks, regards,

Peter.
