From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH 01/19] mmc: mmci: regroup and define dma operations
Date: Wed, 11 Jul 2018 14:16:00 +0200
Message-ID: <CAPDyKFo0q5Yps1whPmaUQJAV3tXx91WPmxtMF_ov43qP=djQfg@mail.gmail.com>
References: <1528809280-31116-1-git-send-email-ludovic.Barre@st.com>
 <1528809280-31116-2-git-send-email-ludovic.Barre@st.com> <CAPDyKFpt5HUeUqaoS9icDodM+r64jB9vQ=zTecO0tuBv=TtOXg@mail.gmail.com>
 <d93e6886-1dee-7915-459f-466a54d0c242@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <d93e6886-1dee-7915-459f-466a54d0c242@st.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ludovic BARRE <ludovic.barre@st.com>
Cc: Rob Herring <robh+dt@kernel.org>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, Alexandre Torgue <alexandre.torgue@st.com>, Gerald Baeza <gerald.baeza@st.com>, Linux ARM <linux-arm-kernel@lists.infradead.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, devicetree@vger.kernel.org, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

On 11 July 2018 at 11:41, Ludovic BARRE <ludovic.barre@st.com> wrote:
>
>
> On 07/05/2018 05:17 PM, Ulf Hansson wrote:
>>
>> On 12 June 2018 at 15:14, Ludovic Barre <ludovic.Barre@st.com> wrote:
>>>
>>> From: Ludovic Barre <ludovic.barre@st.com>
>>>
>>> Prepare mmci driver to manage dma interface by new property.
>>> This patch defines and regroups dma operations for mmci drivers.
>>> mmci_dma_XX prototypes are added to call member of mmci_dma_ops
>>> if not null. Based on legacy need, a mmci dma interface has been
>>> defined with:
>>> -mmci_dma_setup
>>> -mmci_dma_release
>>> -mmci_dma_pre_req
>>> -mmci_dma_start
>>> -mmci_dma_finalize
>>> -mmci_dma_post_req
>>> -mmci_dma_error
>>> -mmci_dma_get_next_data
>>
>>
>> As I suggested for one of the other patches, I would rather turn core
>> mmci functions into library functions, which can be either invoked
>> from variant callbacks or assigned directly to them.
>>
>> In other words, I would leave the functions that you move in this
>> patch to stay in mmci.c. Although some needs to be re-factored and we
>> also needs to make some of them available to be called from another
>> file, hence the functions needs to be shared via mmci.h rather than
>> being declared static.
>
>
> In previous exchange mail "STM32MP1 SDMMC driver review"
> we are said:
>
>>>> -dma variant =C3=A0 should fit in Qualcomm implementation, reuse (rena=
me)
>>>> mmci_qcom_dml.c file and integrate ST dma in.

Apologize if I may have lead you in a wrong direction, that was not my inte=
nt.

However, by looking at $subject patch, your seems to be unnecessarily
shuffling code around. I would like to avoid that.

>>>
>>> stm32 sdmmc has an internal dma, no need to use dmaengine API;
>>> So some modifications in mmci (pre/post request, mmci_dma_xx). perhaps
>>> should be done with an ops or not.
>>
>>Yes.
>>
>>The Qualcomm variant is also using an internal DMA, hence I thought
>>there may be something we could re-use, or at least have some new
>>common ops for.
>
> It's not crystal clear for me.
> Do you always agree with a dma ops which allow to address different
> DMA transfer:
> -with dmaengine API
> -sdmmc idma, without dmaengine API
> -...

If we can use a mmci ops callback to manage the variant differences,
that would be perfect. That combined with making the existing DMA
functions in mmci.c converted to "library" functions, which the mmci
ops callbacks can call, in order to re-use code.

When that isn't really suitable, we may need to add a "quirk" instead,
which would be specific for that particular variant. Along the lines
of what we already do for variant specifics inside mmci.c.

I think we have to decide on case by case basis, what fits best.

Hope this makes a better explanation. If not, please tell, and I can
take an initial stab and post a patch to show you with code how I mean
to move forward.

>
>
>>
>> Let me take a concrete example on how I would move forward, hopefully
>> that explains it a bit better. Please see below.
>>
>> [...]
>>
>>> -/*
>>> - * All the DMA operation mode stuff goes inside this ifdef.
>>> - * This assumes that you have a generic DMA device interface,
>>> - * no custom DMA interfaces are supported.
>>> - */
>>> -#ifdef CONFIG_DMA_ENGINE
>>> -static void mmci_dma_setup(struct mmci_host *host)
>>> -{
>>> -       const char *rxname, *txname;
>>> -       struct variant_data *variant =3D host->variant;
>>> -
>>> -       host->dma_rx_channel =3D
>>> dma_request_slave_channel(mmc_dev(host->mmc), "rx");
>>> -       host->dma_tx_channel =3D
>>> dma_request_slave_channel(mmc_dev(host->mmc), "tx");
>>> -
>>> -       /* initialize pre request cookie */
>>> -       host->next_data.cookie =3D 1;
>>> -
>>> -       /*
>>> -        * If only an RX channel is specified, the driver will
>>> -        * attempt to use it bidirectionally, however if it is
>>> -        * is specified but cannot be located, DMA will be disabled.
>>> -        */
>>> -       if (host->dma_rx_channel && !host->dma_tx_channel)
>>> -               host->dma_tx_channel =3D host->dma_rx_channel;
>>> -
>>> -       if (host->dma_rx_channel)
>>> -               rxname =3D dma_chan_name(host->dma_rx_channel);
>>> -       else
>>> -               rxname =3D "none";
>>> -
>>> -       if (host->dma_tx_channel)
>>> -               txname =3D dma_chan_name(host->dma_tx_channel);
>>> -       else
>>> -               txname =3D "none";
>>> -
>>> -       dev_info(mmc_dev(host->mmc), "DMA channels RX %s, TX %s\n",
>>> -                rxname, txname);
>>> -
>>> -       /*
>>> -        * Limit the maximum segment size in any SG entry according to
>>> -        * the parameters of the DMA engine device.
>>> -        */
>>> -       if (host->dma_tx_channel) {
>>> -               struct device *dev =3D host->dma_tx_channel->device->de=
v;
>>> -               unsigned int max_seg_size =3D dma_get_max_seg_size(dev)=
;
>>> -
>>> -               if (max_seg_size < host->mmc->max_seg_size)
>>> -                       host->mmc->max_seg_size =3D max_seg_size;
>>> -       }
>>> -       if (host->dma_rx_channel) {
>>> -               struct device *dev =3D host->dma_rx_channel->device->de=
v;
>>> -               unsigned int max_seg_size =3D dma_get_max_seg_size(dev)=
;
>>> -
>>> -               if (max_seg_size < host->mmc->max_seg_size)
>>> -                       host->mmc->max_seg_size =3D max_seg_size;
>>> -       }
>>
>>
>> Everything above shall be left as generic library function,
>> mmci_dma_setup() and I would share it via mmci.h and thus change it
>> from being static.
>>
>
> each interfaces mmci_dma_XXX have very different needs depending
> dma_ops (legacy, sdmmc idma)

Right. This was just one example.

If I understand, what you are suggesting is to make all of them being
variant specific callbacks, so I assume that would solve the problems.
Just to be clear, I have no problem with that.

Although, that doesn't mean we can't re-use existing dma functions in
mmci.c, when that makes sense.

[...]

Kind regards
Uffe
