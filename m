From: Piotr Sroka <piotrs@cadence.com>
Subject: RE: [v3 3/3] mmc: sdhci-cadence: Update PHY delay configuration
Date: Tue, 21 Mar 2017 07:19:17 +0000
Message-ID: <201703210719.v2L7JHLV032698@lvloginb.cadence.com>
References: <1489754302-10996-1-git-send-email-piotrs@cadence.com>
 <1489754503-16559-1-git-send-email-piotrs@cadence.com>
 <CAK7LNAQGOeZVqvc=6Agq2xN5B5cBMtaCAkS8-V6uBoO1ziSSuw@mail.gmail.com>
 <DM5PR07MB308222A445B7A39CBFE4896ADD3A0@DM5PR07MB3082.namprd07.prod.outlook.com>
 <CAK7LNAR_i0Q0jymENMSxu-hn4S3KQ3kEwbPmju1H5K2pmMranw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAK7LNAR_i0Q0jymENMSxu-hn4S3KQ3kEwbPmju1H5K2pmMranw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, Ulf Hansson <ulf.hansson@linaro.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Piotr <piotrs@cadence.com>
List-Id: linux-mmc@vger.kernel.org

Hi Masahiro,

> Hi Piotr,
> 
> 2017-03-20 17:47 GMT+09:00 Piotr Sroka <piotrs@cadence.com>:
> >
> >>
> >> > @@ -227,6 +267,7 @@ static int sdhci_cdns_probe(struct platform_device *pdev)
> >> >         struct sdhci_cdns_priv *priv;
> >> >         struct clk *clk;
> >> >         int ret;
> >> > +       struct device *dev = &pdev->dev;
> >> >
> >> >         clk = devm_clk_get(&pdev->dev, NULL);
> >>
> >>
> >> If you add "dev", please use it for devm_clk_get, too.
> >>
> > I did on the first patch version but Ulf pointed that this is unrelated change and should be removed.
> > Therefore I remove it.
> 
> Ah, OK.
> 
> Could you consider to send a separate patch for this?
> 
Ok. If v5 is needed I will add additional patch making this modification. If not I will prepare a spearate patch.


Best Regards
Piotr Sroka
