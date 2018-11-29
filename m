From: Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH v2 1/3] mmc: sdhci: add support for using external DMA
 devices
Date: Thu, 29 Nov 2018 12:48:13 +0200
Message-ID: <d9091e09-da8d-5fd2-0957-30d34c2a0e21@intel.com>
References: <1542007566-9449-1-git-send-email-zhang.chunyan@linaro.org>
 <1542007566-9449-2-git-send-email-zhang.chunyan@linaro.org>
 <84836600-c705-9ac3-297e-bb67a611daca@intel.com>
 <CAAfSe-us5aKOv9F6KHwvJR_cMAF8KFo6W1Gs_B3zBiNOuD10Qg@mail.gmail.com>
 <f78de042-69cf-5345-f16f-236d04d57051@intel.com>
 <CAAfSe-sfe5A7b_8iBiUmvi_mo1zRZ_Oh0yu-uwXo8Hv+WBftWQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAAfSe-sfe5A7b_8iBiUmvi_mo1zRZ_Oh0yu-uwXo8Hv+WBftWQ@mail.gmail.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Chunyan Zhang <zhang.lyra@gmail.com>
Cc: Chunyan Zhang <zhang.chunyan@linaro.org>, Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>, Mark Brown <broonie@kernel.org>, kishon@ti.com, nsekhar@ti.com
List-Id: linux-mmc@vger.kernel.org

On 29/11/18 11:59 AM, Chunyan Zhang wrote:
> Hi Adrian,
> 
> On Thu, 29 Nov 2018 at 15:36, Adrian Hunter <adrian.hunter@intel.com> wrote:
>>
>> On 29/11/18 8:22 AM, Chunyan Zhang wrote:
>>> On Tue, 20 Nov 2018 at 21:41, Adrian Hunter <adrian.hunter@intel.com> wrote:
>>>>
>>>> On 12/11/18 9:26 AM, Chunyan Zhang wrote:
>>>>> Some standard SD host controllers can support both external dma
>>>>> controllers as well as ADMA/SDMA in which the SD host controller
>>>>> acts as DMA master. TI's omap controller is the case as an example.
>>>>>
>>>>> Currently the generic SDHCI code supports ADMA/SDMA integrated in
>>>>> the host controller but does not have any support for external DMA
>>>>> controllers implemented using dmaengine, meaning that custom code is
>>>>> needed for any systems that use an external DMA controller with SDHCI.
>>>>
>>>> I still think you probably need to reset the DMA if there are transfer
>>>> errors - perhaps you could comment on that.  Also there are some comments below.
>>>
>>> With regard to "transfer error", do you mean if
>>> sdhci_external_dma_setup() failed?
>>
>> No, I mean any error interrupt that can leave the DMA uncompleted.  For
>> SDHCI, resetting the data circuit cleans that up, but presumably something
>> is needed for external DMA?
> 
> Yes, it should need a dmaengine_terminate_all().
> 
> How about adding that at here (I will wrap it up of course):
> https://elixir.bootlin.com/linux/v4.19.5/source/drivers/mmc/host/sdhci.c#L2553

Yes except we really need to reverse
	if (host->flags & SDHCI_REQ_USE_DMA) {
	}
	if (sdhci_needs_reset(host, mrq)) {
	}
so that we do not unmap before killing the dma

Perhaps you could send that as a separate patch.

> Is there somewhere else I'm missing?

Testing ;-)
