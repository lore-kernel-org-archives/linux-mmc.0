From: Thomas Abraham <thomas.abraham@linaro.org>
Subject: Re: [PATCH 1/7] mmc: dw_mmc: lookup for optional biu and ciu clocks
Date: Thu, 10 May 2012 14:50:04 +0530
Message-ID: <CAJuYYwQ5NLvsYK2iAaXtggbjYx7EUvc2RDjyFyrazke2E2wgiQ@mail.gmail.com>
References: <1335935266-25289-1-git-send-email-thomas.abraham@linaro.org>
	<1335935266-25289-2-git-send-email-thomas.abraham@linaro.org>
	<CAAG0J9-NDM9wLKpq04ofPkvFqiWxjmP84ojsP9Hfs0SJ_0FaXg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAAG0J9-NDM9wLKpq04ofPkvFqiWxjmP84ojsP9Hfs0SJ_0FaXg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: James Hogan <james@albanarts.com>
Cc: linux-mmc@vger.kernel.org, devicetree-discuss@lists.ozlabs.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, cjb@laptop.org, grant.likely@secretlab.ca, rob.herring@calxeda.com, linux-samsung-soc@vger.kernel.org, kgene.kim@samsung.com, patches@linaro.org
List-Id: linux-mmc@vger.kernel.org

On 2 May 2012 20:23, James Hogan <james@albanarts.com> wrote:
> Hi
>
> On 2 May 2012 06:07, Thomas Abraham <thomas.abraham@linaro.org> wrote=
:
>> Some platforms allow for clock gating and control of bus interface u=
nit clock
>> and card interface unit clock. Add support for clock lookup of optio=
nal biu
>> and ciu clocks for clock gating and clock speed determination.
>>
>> Signed-off-by: Abhilash Kesavan <a.kesavan@samsung.com>
>> Signed-off-by: Thomas Abraham <thomas.abraham@linaro.org>
>> ---
>> =A0drivers/mmc/host/dw_mmc.c =A0| =A0 35 +++++++++++++++++++++++++++=
++++----
>> =A0include/linux/mmc/dw_mmc.h | =A0 =A04 ++++
>> =A02 files changed, 35 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
>> index 1532357..036846f 100644
>> --- a/drivers/mmc/host/dw_mmc.c
>> +++ b/drivers/mmc/host/dw_mmc.c
>> @@ -1938,19 +1938,35 @@ int dw_mci_probe(struct dw_mci *host)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return -ENODEV;
>> =A0 =A0 =A0 =A0}
>>
>> - =A0 =A0 =A0 if (!host->pdata->bus_hz) {
>> + =A0 =A0 =A0 host->biu_clk =3D clk_get(&host->dev, "biu");
>
> These clock names sound quite platform specific (what if they're
> called something else on another platform, or another platform has
> separate ones for different instantiations of the block?). Perhaps th=
e
> clk names should get passed in through platform data. I haven't looke=
d
> how other drivers handle that though.

The clock names 'biu' and 'ciu' are derived from the terminology used
by the data sheet of the mshc controller. The 'biu' clock is the
source clock for the bus interface unit and 'ciu' clock is the clock
source for card interface unit of the controller. So these names are
generic and not specific to a platform. Passing clock names from
platform data is generally frowned upon.

>
>> + =A0 =A0 =A0 if (IS_ERR(host->biu_clk))
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_info(&host->dev, "biu clock not av=
ailable\n");
>
> In this case, should it set host->biu_clk to NULL or are clk_disable
> and clk_put guaranteed to handle an IS_ERR value?

Yes, the clk_disable will have to be preceded with a IS_ERR check. I
will fix this.

>
>> + =A0 =A0 =A0 else
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 clk_enable(host->biu_clk);
>> +
>> + =A0 =A0 =A0 host->ciu_clk =3D clk_get(&host->dev, "ciu");
>> + =A0 =A0 =A0 if (IS_ERR(host->ciu_clk))
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_info(&host->dev, "ciu clock not av=
ailable\n");
>
> same here

Ok, this also will be fixed.

>
>> + =A0 =A0 =A0 else
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 clk_enable(host->ciu_clk);
>> +
>> + =A0 =A0 =A0 if (IS_ERR(host->ciu_clk))
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 host->bus_hz =3D host->pdata->bus_hz;
>> + =A0 =A0 =A0 else
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 host->bus_hz =3D clk_get_rate(host->ci=
u_clk);
>> +
>> + =A0 =A0 =A0 if (!host->bus_hz) {
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0dev_err(&host->dev,
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0"Platform data must s=
upply bus speed\n");
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -ENODEV;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D -ENODEV;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto err_clk;
>> =A0 =A0 =A0 =A0}
>>
>> - =A0 =A0 =A0 host->bus_hz =3D host->pdata->bus_hz;
>> =A0 =A0 =A0 =A0host->quirks =3D host->pdata->quirks;
>>
>> =A0 =A0 =A0 =A0spin_lock_init(&host->lock);
>> =A0 =A0 =A0 =A0INIT_LIST_HEAD(&host->queue);
>>
>> -
>> =A0 =A0 =A0 =A0host->dma_ops =3D host->pdata->dma_ops;
>> =A0 =A0 =A0 =A0dw_mci_init_dma(host);
>>
>> @@ -2095,6 +2111,13 @@ err_dmaunmap:
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0regulator_disable(host->vmmc);
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0regulator_put(host->vmmc);
>> =A0 =A0 =A0 =A0}
>> + =A0 =A0 =A0 kfree(host);
>
> what's this about?

This is wrong. It should not have been here. I will fix this. Thanks
for pointing this out.

Thanks,
Thomas.
