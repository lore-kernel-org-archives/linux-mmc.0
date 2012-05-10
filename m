From: Thomas Abraham <thomas.abraham@linaro.org>
Subject: Re: [PATCH 1/7] mmc: dw_mmc: lookup for optional biu and ciu clocks
Date: Thu, 10 May 2012 14:41:07 +0530
Message-ID: <CAJuYYwSn9kMEW8nPiPe9o+OHR0D00oBNNfuFq6ZaXw1jwx+oeA@mail.gmail.com>
References: <1335935266-25289-1-git-send-email-thomas.abraham@linaro.org>
	<1335935266-25289-2-git-send-email-thomas.abraham@linaro.org>
	<CAFbHwiTZOOP1HwZQPPKBei3aGhbBjFyJ4QLJ+Ea465L6r6vEYg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAFbHwiTZOOP1HwZQPPKBei3aGhbBjFyJ4QLJ+Ea465L6r6vEYg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Will Newton <will.newton@gmail.com>
Cc: linux-mmc@vger.kernel.org, devicetree-discuss@lists.ozlabs.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, cjb@laptop.org, grant.likely@secretlab.ca, rob.herring@calxeda.com, linux-samsung-soc@vger.kernel.org, kgene.kim@samsung.com, patches@linaro.org
List-Id: linux-mmc@vger.kernel.org

On 2 May 2012 14:47, Will Newton <will.newton@gmail.com> wrote:
> On Wed, May 2, 2012 at 6:07 AM, Thomas Abraham
> <thomas.abraham@linaro.org> wrote:
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
>> + =A0 =A0 =A0 if (IS_ERR(host->biu_clk))
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_info(&host->dev, "biu clock not av=
ailable\n");
>> + =A0 =A0 =A0 else
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 clk_enable(host->biu_clk);
>> +
>> + =A0 =A0 =A0 host->ciu_clk =3D clk_get(&host->dev, "ciu");
>> + =A0 =A0 =A0 if (IS_ERR(host->ciu_clk))
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_info(&host->dev, "ciu clock not av=
ailable\n");
>
> Should these printks be at debug level? I'm not 100% sure either way
> but it could be a little noisy on systems that do not use these
> clocks.

Right. I will change dev_info to dev_dbg.

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
>> +
>> +err_clk:
>> + =A0 =A0 =A0 clk_disable(host->ciu_clk);
>> + =A0 =A0 =A0 clk_disable(host->biu_clk);
>> + =A0 =A0 =A0 clk_put(host->ciu_clk);
>> + =A0 =A0 =A0 clk_put(host->biu_clk);
>
> Are these calls safe, or do we need to check IS_ERR as above?

The clk_disable is safe on Samsung platforms but it cannot be assumed
for other platforms. So, the IS_ERR check will be added before
clk_disable. clk_put will not need the IS_ERR check. Thanks for
pointing this out.

>
>> =A0 =A0 =A0 =A0return ret;
>> =A0}
>> =A0EXPORT_SYMBOL(dw_mci_probe);
>> @@ -2128,6 +2151,10 @@ void dw_mci_remove(struct dw_mci *host)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0regulator_put(host->vmmc);
>> =A0 =A0 =A0 =A0}
>>
>> + =A0 =A0 =A0 clk_disable(host->ciu_clk);
>> + =A0 =A0 =A0 clk_disable(host->biu_clk);
>> + =A0 =A0 =A0 clk_put(host->ciu_clk);
>> + =A0 =A0 =A0 clk_put(host->biu_clk);
>
> Likewise.

Yes, will be fixed.

Thanks,
Thomas.

[...]
