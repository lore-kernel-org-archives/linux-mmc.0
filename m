Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08589C4361B
	for <linux-mmc@archiver.kernel.org>; Mon, 14 Dec 2020 23:33:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BB46622510
	for <linux-mmc@archiver.kernel.org>; Mon, 14 Dec 2020 23:33:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725945AbgLNXdM (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 14 Dec 2020 18:33:12 -0500
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:51491 "EHLO
        out3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725789AbgLNXdB (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 14 Dec 2020 18:33:01 -0500
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id DF0815C0148;
        Mon, 14 Dec 2020 18:31:53 -0500 (EST)
Received: from imap2 ([10.202.2.52])
  by compute3.internal (MEProxy); Mon, 14 Dec 2020 18:31:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aj.id.au; h=
        mime-version:message-id:in-reply-to:references:date:from:to:cc
        :subject:content-type; s=fm1; bh=LFF5/tO9nY1OZRQNLJeM62EI6jzrxQX
        MkvpYLECbH9I=; b=P6AYp58NjCbaJzJB7EQ9YtLJ92XBQwmiwLDirRHAw4p1laV
        ql7LGdi/IY8aIaL+6Aj53nj6UVA6rIK7dVDUnKtsaCSh940NnyAema4wMNX67IFb
        9BxRzLARt5Jy1fEtcaII0WPmfWofSiwvoLU+jdaKqtVgIp9vo/udRhhgH6a/mTFG
        SJTqJAykV11Pxp+Kc+EhqHHkBj0m6I+AP5pauQ1FDZhcHwcCvrjfiIylkWduFaT0
        2FsEzwo5NvfUGhBWAaDaj4XFBUm/sBArucl2BpCv5DJt11eCIR6T426p1c7b7STY
        ir5J1m12LwMt6FpxvdCsRiFuMLdNlXO+N7zZnfg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=LFF5/t
        O9nY1OZRQNLJeM62EI6jzrxQXMkvpYLECbH9I=; b=R2FkRaT/Ga7w1WpVs8t5SQ
        ir4SFkEy1jNs6LUChTaQzuQvfFWZu6cjf6elSXj6oS8vytP04U74H4O7tgpLriSM
        Orn0UfhQc1kBWf+T7HT0sp859sxhQ/+9QXIaGRuZtHnIB/0zhJWsjmOaXSru/Tjk
        ErbACiqu5OKD2Doc78BD8QLwX1eW58nv3QfJcGZ7x5jbjR5D/VHjJfDC3SCEIUfu
        8kV2fyAjSD1CbJ/fI/gkTNCmLFyINdmjM96niDqzIuVEpkhh2ywDz0VCZProXNWd
        XUTtJA779p49F218Hwad1m8IXiBGuncsPNwC1Vvm/2C4GsgaLR0zso+LbSlbJI+A
        ==
X-ME-Sender: <xms:6PXXX4jxW_gEbq9RtF6OTNO1Wh9nKZUXH8g1dmbMbJEQDsfMtaGkqQ>
    <xme:6PXXXxAjfDvweqT3TMoi2snE1fYL3_jW3sr1ixRrdL-sTEe4e3jFffb91q8uIVBLT
    PmsKlTpv6x3vBI8yQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrudekledguddvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvffutgesthdtredtreerjeenucfhrhhomhepfdetnhgu
    rhgvficulfgvfhhfvghrhidfuceorghnughrvgifsegrjhdrihgurdgruheqnecuggftrf
    grthhtvghrnhepuddttdekueeggedvtddtueekiedutdfguedutdefieeuteefieelteet
    vddthfeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
    eprghnughrvgifsegrjhdrihgurdgruh
X-ME-Proxy: <xmx:6PXXXwGmewVKVN_u7eGrtkLxmpbahAIRhl3_LCWLXSEahaNN_J7BSA>
    <xmx:6PXXX5QAmpiaRkSD_chmsx0m3U5D_ksMIQDOthEqPQgaOcyl3VG8mg>
    <xmx:6PXXX1z7ynJX5iT7XaSyvh-b8bczXebrLmq1TMLX6KGs64XznnPFMQ>
    <xmx:6fXXX0yRdOggj1yG1JFdgzAlUTENLFI_HoFARIGIX67tjDU7cyvCqQ>
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 8B284E00DD; Mon, 14 Dec 2020 18:31:50 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.3.1-61-gb52c239-fm-20201210.001-gb52c2396
Mime-Version: 1.0
Message-Id: <2ba456f0-d9ca-4ca6-9dd0-ae7b5f959333@www.fastmail.com>
In-Reply-To: <CAPDyKFrceNPNz9+88p+mzbYEo-ZqWOwTBWaqycxPr3MQEFtbaA@mail.gmail.com>
References: <20201208012615.2717412-1-andrew@aj.id.au>
 <20201208012615.2717412-2-andrew@aj.id.au>
 <CAPDyKFrceNPNz9+88p+mzbYEo-ZqWOwTBWaqycxPr3MQEFtbaA@mail.gmail.com>
Date:   Tue, 15 Dec 2020 10:01:31 +1030
From:   "Andrew Jeffery" <andrew@aj.id.au>
To:     "Ulf Hansson" <ulf.hansson@linaro.org>
Cc:     linux-mmc <linux-mmc@vger.kernel.org>,
        "Rob Herring" <robh+dt@kernel.org>,
        "Joel Stanley" <joel@jms.id.au>,
        "Adrian Hunter" <adrian.hunter@intel.com>,
        "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
        DTML <devicetree@vger.kernel.org>,
        "Linux ARM" <linux-arm-kernel@lists.infradead.org>,
        linux-aspeed <linux-aspeed@lists.ozlabs.org>,
        "Ryan Chen" <ryan_chen@aspeedtech.com>
Subject: =?UTF-8?Q?Re:_[PATCH_v5_1/6]_mmc:_core:_Add_helper_for_parsing_clock_pha?=
 =?UTF-8?Q?se_properties?=
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org



On Tue, 15 Dec 2020, at 02:18, Ulf Hansson wrote:
> On Tue, 8 Dec 2020 at 02:26, Andrew Jeffery <andrew@aj.id.au> wrote:
> >
> > Drivers for MMC hosts that accept phase corrections can take advantage
> > of the helper by embedding a mmc_clk_phase_map_t object in their
> > private data and invoking mmc_of_parse_clk_phase() to extract phase
> > parameters. It is the responsibility of the host driver to translate and
> > apply the extracted values to hardware as required.
> >
> > Signed-off-by: Andrew Jeffery <andrew@aj.id.au>
> > ---
> >  drivers/mmc/core/host.c  | 44 ++++++++++++++++++++++++++++++++++++++++
> >  include/linux/mmc/host.h | 17 ++++++++++++++++
> >  2 files changed, 61 insertions(+)
> >
> > diff --git a/drivers/mmc/core/host.c b/drivers/mmc/core/host.c
> > index 96b2ca1f1b06..b1697f00c4b5 100644
> > --- a/drivers/mmc/core/host.c
> > +++ b/drivers/mmc/core/host.c
> > @@ -163,6 +163,50 @@ static void mmc_retune_timer(struct timer_list *t)
> >         mmc_retune_needed(host);
> >  }
> >
> > +static void mmc_of_parse_timing_phase(struct device *dev, const char *prop,
> > +                                     struct mmc_clk_phase *phase)
> > +{
> > +       int degrees[2] = {0};
> > +       int rc;
> > +
> > +       rc = device_property_read_u32_array(dev, prop, degrees, 2);
> > +       phase->valid = !rc;
> > +       if (phase->valid) {
> > +               phase->in_deg = degrees[0];
> > +               phase->out_deg = degrees[1];
> > +       }
> > +}
> > +
> > +void
> > +mmc_of_parse_clk_phase(struct mmc_host *host, mmc_clk_phase_map_t map)
> 
> Would you mind to change to pass a "struct mmc_clk_phase_map *map" to this?
> 
> See more comments below.
> 
> > +{
> > +       struct device *dev = host->parent;
> > +
> > +       mmc_of_parse_timing_phase(dev, "clk-phase-legacy",
> > +                                 &map[MMC_TIMING_LEGACY]);
> > +       mmc_of_parse_timing_phase(dev, "clk-phase-mmc-hs",
> > +                                 &map[MMC_TIMING_MMC_HS]);
> > +       mmc_of_parse_timing_phase(dev, "clk-phase-sd-hs",
> > +                                 &map[MMC_TIMING_SD_HS]);
> > +       mmc_of_parse_timing_phase(dev, "clk-phase-uhs-sdr12",
> > +                                 &map[MMC_TIMING_UHS_SDR12]);
> > +       mmc_of_parse_timing_phase(dev, "clk-phase-uhs-sdr25",
> > +                                 &map[MMC_TIMING_UHS_SDR25]);
> > +       mmc_of_parse_timing_phase(dev, "clk-phase-uhs-sdr50",
> > +                                 &map[MMC_TIMING_UHS_SDR50]);
> > +       mmc_of_parse_timing_phase(dev, "clk-phase-uhs-sdr104",
> > +                                 &map[MMC_TIMING_UHS_SDR104]);
> > +       mmc_of_parse_timing_phase(dev, "clk-phase-uhs-ddr50",
> > +                                 &map[MMC_TIMING_UHS_DDR50]);
> > +       mmc_of_parse_timing_phase(dev, "clk-phase-mmc-ddr52",
> > +                                 &map[MMC_TIMING_MMC_DDR52]);
> > +       mmc_of_parse_timing_phase(dev, "clk-phase-mmc-hs200",
> > +                                 &map[MMC_TIMING_MMC_HS200]);
> > +       mmc_of_parse_timing_phase(dev, "clk-phase-mmc-hs400",
> > +                                 &map[MMC_TIMING_MMC_HS400]);
> > +}
> > +EXPORT_SYMBOL(mmc_of_parse_clk_phase);
> > +
> >  /**
> >   *     mmc_of_parse() - parse host's device-tree node
> >   *     @host: host whose node should be parsed.
> > diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h
> > index 01bba36545c5..bc4731c9738f 100644
> > --- a/include/linux/mmc/host.h
> > +++ b/include/linux/mmc/host.h
> > @@ -79,6 +79,22 @@ struct mmc_ios {
> >         bool enhanced_strobe;                   /* hs400es selection */
> >  };
> >
> > +struct mmc_clk_phase {
> > +       bool valid;
> > +       u16 in_deg;
> > +       u16 out_deg;
> > +};
> > +
> > +/*
> > + * Define a type to map between bus timings and phase correction values. To
> > + * avoid bloat in struct mmc_host we leave it to the host driver to define the
> > + * phase map object in its private data if it supports phase correction.
> > + * However, mmc_of_parse_clk_phase() is provided by the mmc core and needs the
> > + * provided array to be correctly sized, so typedef an appropriately sized
> > + * array to minimise the chance that the wrong size object is passed.
> > + */
> > +typedef struct mmc_clk_phase mmc_clk_phase_map_t[MMC_TIMING_MMC_HS400 + 1];
> > +
> 
> Nitpick: I would appreciate if we could avoid using "typedefs", as I
> think they in many cases makes the code harder to read. How about
> doing this instead?
> 
> #define MMC_NUM_CLK_PHASES (MMC_TIMING_MMC_HS400 + 1)
> 
> struct mmc_clk_phase_map {
>         struct mmc_clk_phase phase[MMC_NUM_CLK_PHASES];
> };
> 
> [...]

Right; I experimented with that approach and felt it was kinda clunky (hence 
the typedef), but I'll respin the series doing as such.

Thanks,

Andrew
