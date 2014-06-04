From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH 1/8] mmc: sdhci-st: Intial support for ST SDHCI controller
Date: Wed, 4 Jun 2014 13:06:07 +0200
Message-ID: <CAPDyKFqvQca9RfsVVyfeC9r=pEDM2mBkfS7SzpYZHHXMnHfyUQ@mail.gmail.com>
References: <1400771902-26553-1-git-send-email-peter.griffin@linaro.org>
	<1400771902-26553-2-git-send-email-peter.griffin@linaro.org>
	<CAPDyKFpanhYbf89tEKru=_oOfBGZZxs0=eqr_5MvU9v_bGULjQ@mail.gmail.com>
	<20140604084831.GB23469@griffinp-ThinkPad-X1-Carbon-2nd>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qg0-f45.google.com ([209.85.192.45]:40624 "EHLO
	mail-qg0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752432AbaFDLGI convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 4 Jun 2014 07:06:08 -0400
Received: by mail-qg0-f45.google.com with SMTP id z60so15335953qgd.18
        for <linux-mmc@vger.kernel.org>; Wed, 04 Jun 2014 04:06:08 -0700 (PDT)
In-Reply-To: <20140604084831.GB23469@griffinp-ThinkPad-X1-Carbon-2nd>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Peter Griffin <peter.griffin@linaro.org>
Cc: "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Maxime Coquelin <maxime.coquelin@st.com>, Patrice CHOTARD <patrice.chotard@st.com>, Srinivas Kandagatla <srinivas.kandagatla@gmail.com>, Chris Ball <chris@printf.net>, Ulf Hansson <ulf.hansson@linaro.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, kernel@stlinux.com, linux-mmc <linux-mmc@vger.kernel.org>, Giuseppe Cavallaro <peppe.cavallaro@st.com>, Lee Jones <lee.jones@linaro.org>

On 4 June 2014 10:48, Peter Griffin <peter.griffin@linaro.org> wrote:
> Hi Ulf,
>
> Thanks for reviewing, see my comments below: -
>
> On Fri, 23 May 2014, Ulf Hansson wrote:
>> > +static unsigned int sdhci_st_get_max_clk(struct sdhci_host *host)
>> > +{
>> > +       struct sdhci_pltfm_host *pltfm_host =3D sdhci_priv(host);
>> > +
>> > +       return clk_get_rate(pltfm_host->clk);
>> > +}
>>
>> There are sdhci library function for the above:
>> sdhci_pltfm_clk_get_max_clock()
>
> I've fixed in v2 to use the library function
>
>> > +       host->mmc->caps |=3D MMC_CAP_8_BIT_DATA | MMC_CAP_BUS_WIDT=
H_TEST
>> > +                       | MMC_CAP_1_8V_DDR;
>>
>> Comment below.
>>
>> > +
>> > +       if (of_property_read_bool(np, "non-removable"))
>> > +               host->mmc->caps |=3D MMC_CAP_NONREMOVABLE;
>>
>> MMC_CAP_1_8V_DDR, MMC_CAP_8_BIT_DATA, MMC_CAP_NONREMOVABLE aren=E2=80=
=99t
>> those board specific capabilities?
>
> Yep
>>
>> Unless there are something that prevents you from using the common m=
mc
>> DT parser, I would suggest you to use it. mmc_of_parse(). Thus you c=
an
>> provide these capabilities through DT instead.
>
> Thanks for pointing that out, I've switched over to using mmc_of_pars=
e,
> and everything works as expected.
>
> Also as an added bonus this will simplify support for the next SoC wh=
ich
> needs access to the high speed ddr / sdr bindings which
> mmc_of_parse already supports :-)
>
> In v2 I've also removed the reset controller code from this platform =
driver
> with the intention of adding it back in, in the generic code. The ide=
a
> would be that an additional 'reset' binding could be provided, which =
if
> present would be used to deassert the IP reset line of the controller=
 at
> probe / resume, and assert reset at remove / sleep.
>
> Is this something you view as useful, if so I will prepare some RFC p=
atches?

Sounds useful. Please go ahead and send patches! :-)

Kind regards
Uffe
