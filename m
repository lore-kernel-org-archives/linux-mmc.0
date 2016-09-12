From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH 4/4] mmc: sdhci-st: Handle interconnect clock
Date: Mon, 12 Sep 2016 14:35:23 +0200
Message-ID: <CAPDyKFpVKYzJEAWkHsp2ZZdS=tQmVjFRymkXFHxyGqmgteNbUw@mail.gmail.com>
References: <20160908091136.17301-1-lee.jones@linaro.org> <20160908091136.17301-5-lee.jones@linaro.org>
 <20160908115849.GS4921@dell>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <20160908115849.GS4921@dell>
Sender: stable-owner@vger.kernel.org
To: Lee Jones <lee.jones@linaro.org>
Cc: Patrice CHOTARD <patrice.chotard@st.com>, Peter Griffin <peter.griffin@linaro.org>, Rob Herring <robh@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, kernel@stlinux.com, "# 4.0+" <stable@vger.kernel.org>, linux-mmc <linux-mmc@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

On 8 September 2016 at 13:58, Lee Jones <lee.jones@linaro.org> wrote:
> Sorry Adrian, left you of the list.  Rectifying.
>
> FYI, this patch is due for the v4.8 -rcs:
>
>   http://www.spinics.net/lists/kernel/msg2338219.html
>
>> Some ST platforms contain interconnect (ICN) clocks which must be handed
>> correctly in order to obtain full functionality of a given IP.  In this
>> case, if the ICN clocks are not handled properly by the ST SDHCI driver
>> MMC will break and the following output can be observed:
>>
>>     [   13.916949] mmc0: Timeout waiting for hardware interrupt.
>>     [   13.922349] sdhci: =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D REGISTER DUM=
P (mmc0)=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>>     [   13.928175] sdhci: Sys addr: 0x00000000 | Version:  0x00001002
>>     [   13.933999] sdhci: Blk size: 0x00007040 | Blk cnt:  0x00000001
>>     [   13.939825] sdhci: Argument: 0x00fffff0 | Trn mode: 0x00000013
>>     [   13.945650] sdhci: Present:  0x1fff0206 | Host ctl: 0x00000011
>>     [   13.951475] sdhci: Power:    0x0000000f | Blk gap:  0x00000080
>>     [   13.957300] sdhci: Wake-up:  0x00000000 | Clock:    0x00003f07
>>     [   13.963126] sdhci: Timeout:  0x00000004 | Int stat: 0x00000000
>>     [   13.968952] sdhci: Int enab: 0x02ff008b | Sig enab: 0x02ff008b
>>     [   13.974777] sdhci: AC12 err: 0x00000000 | Slot int: 0x00000000
>>     [   13.980602] sdhci: Caps:     0x21ed3281 | Caps_1:   0x00000000
>>     [   13.986428] sdhci: Cmd:      0x0000063a | Max curr: 0x00000000
>>     [   13.992252] sdhci: Host ctl2: 0x00000000
>>     [   13.996166] sdhci: ADMA Err: 0x00000000 | ADMA Ptr: 0x7c048200
>>     [   14.001990] sdhci: =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D
>>     [   14.009802] mmc0: Got data interrupt 0x02000000 even though no da=
ta operation was in progress.
>>
>> A decent point was raised about minimising the use of a local variable t=
hat
>> we 'could' do without.  I've chosen consistency over the possibility of
>> reducing the local variable count by 1.  Thinking that it's more importa=
nt
>> for the code to be grouped and authoured in a similar manner/style for
>> greater maintainability/readability.
>>
>> Cc: stable@vger.kernel.org
>> Tested-by: Peter Griffin <peter.griffin@linaro.org>
>> Signed-off-by: Lee Jones <lee.jones@linaro.org>

Thanks, applied for fixes!

Adrian, please tell if you have any objections else I intend to send
this for the rcs later this week.

Kind regards
Uffe

>> ---
>>  drivers/mmc/host/sdhci-st.c | 15 ++++++++++++++-
>>  1 file changed, 14 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/mmc/host/sdhci-st.c b/drivers/mmc/host/sdhci-st.c
>> index c95ba83..ed92ce7 100644
>> --- a/drivers/mmc/host/sdhci-st.c
>> +++ b/drivers/mmc/host/sdhci-st.c
>> @@ -28,6 +28,7 @@
>>
>>  struct st_mmc_platform_data {
>>       struct  reset_control *rstc;
>> +     struct  clk *icnclk;
>>       void __iomem *top_ioaddr;
>>  };
>>
>> @@ -353,7 +354,7 @@ static int sdhci_st_probe(struct platform_device *pd=
ev)
>>       struct sdhci_host *host;
>>       struct st_mmc_platform_data *pdata;
>>       struct sdhci_pltfm_host *pltfm_host;
>> -     struct clk *clk;
>> +     struct clk *clk, *icnclk;
>>       int ret =3D 0;
>>       u16 host_version;
>>       struct resource *res;
>> @@ -365,6 +366,11 @@ static int sdhci_st_probe(struct platform_device *p=
dev)
>>               return PTR_ERR(clk);
>>       }
>>
>> +     /* ICN clock isn't compulsory, but use it if it's provided. */
>> +     icnclk =3D devm_clk_get(&pdev->dev, "icn");
>> +     if (IS_ERR(icnclk))
>> +             icnclk =3D NULL;
>> +
>>       rstc =3D devm_reset_control_get(&pdev->dev, NULL);
>>       if (IS_ERR(rstc))
>>               rstc =3D NULL;
>> @@ -389,6 +395,7 @@ static int sdhci_st_probe(struct platform_device *pd=
ev)
>>       }
>>
>>       clk_prepare_enable(clk);
>> +     clk_prepare_enable(icnclk);
>>
>>       /* Configure the FlashSS Top registers for setting eMMC TX/RX dela=
y */
>>       res =3D platform_get_resource_byname(pdev, IORESOURCE_MEM,
>> @@ -400,6 +407,7 @@ static int sdhci_st_probe(struct platform_device *pd=
ev)
>>       }
>>
>>       pltfm_host->clk =3D clk;
>> +     pdata->icnclk =3D icnclk;
>>
>>       /* Configure the Arasan HC inside the flashSS */
>>       st_mmcss_cconfig(np, host);
>> @@ -422,6 +430,7 @@ static int sdhci_st_probe(struct platform_device *pd=
ev)
>>       return 0;
>>
>>  err_out:
>> +     clk_disable_unprepare(icnclk);
>>       clk_disable_unprepare(clk);
>>  err_of:
>>       sdhci_pltfm_free(pdev);
>> @@ -442,6 +451,8 @@ static int sdhci_st_remove(struct platform_device *p=
dev)
>>
>>       ret =3D sdhci_pltfm_unregister(pdev);
>>
>> +     clk_disable_unprepare(pdata->icnclk);
>> +
>>       if (rstc)
>>               reset_control_assert(rstc);
>>
>> @@ -462,6 +473,7 @@ static int sdhci_st_suspend(struct device *dev)
>>       if (pdata->rstc)
>>               reset_control_assert(pdata->rstc);
>>
>> +     clk_disable_unprepare(pdata->icnclk);
>>       clk_disable_unprepare(pltfm_host->clk);
>>  out:
>>       return ret;
>> @@ -475,6 +487,7 @@ static int sdhci_st_resume(struct device *dev)
>>       struct device_node *np =3D dev->of_node;
>>
>>       clk_prepare_enable(pltfm_host->clk);
>> +     clk_prepare_enable(pdata->icnclk);
>>
>>       if (pdata->rstc)
>>               reset_control_deassert(pdata->rstc);
>
> --
> Lee Jones
> Linaro STMicroelectronics Landing Team Lead
> Linaro.org =E2=94=82 Open source software for ARM SoCs
> Follow Linaro: Facebook | Twitter | Blog
