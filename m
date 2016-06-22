From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH 09/12] mmc: sdhci-xenon: add initial Xenon eMMC driver
Date: Wed, 22 Jun 2016 13:04:14 +0200
Message-ID: <CAPDyKFotN0LhR=Vm03HYDCzsRi0Bj_eXrT-JA=zOra4+TTEzPQ@mail.gmail.com>
References: <1465456218-28354-1-git-send-email-gregory.clement@free-electrons.com>
 <1465456218-28354-10-git-send-email-gregory.clement@free-electrons.com>
 <575FA9BF.6070703@intel.com> <878ty8chdr.fsf@free-electrons.com>
 <575FC206.4030903@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <575FC206.4030903@intel.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Gregory CLEMENT <gregory.clement@free-electrons.com>
Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Romain Perier <romain.perier@free-electrons.com>, Jason Cooper <jason@lakedaemon.net>, Andrew Lunn <andrew@lunn.ch>, Omri Itach <omrii@marvell.com>, linux-mmc <linux-mmc@vger.kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, Nadav Haklai <nadavh@marvell.com>, Rob Herring <robh+dt@kernel.org>, Shadi Ammouri <shadi@marvell.com>, Victor Gu <xigu@marvell.com>, Marcin Wojtas <mw@semihalf.com>, Wilson Ding <dingwei@marvell.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
List-Id: linux-mmc@vger.kernel.org

On 14 June 2016 at 10:36, Adrian Hunter <adrian.hunter@intel.com> wrote:
> On 14/06/16 11:19, Gregory CLEMENT wrote:
>> Hi Adrian,
>>
>>  On mar., juin 14 2016, Adrian Hunter <adrian.hunter@intel.com> wrote:
>>
>>> On 09/06/16 10:10, Gregory CLEMENT wrote:
>>>> From: Victor Gu <xigu@marvell.com>
>>>>
>>>> This path adds the driver for the Marvell Xenon eMMC host controller
>>>> which supports eMMC 5.1, SD 3.0.
>>>>
>>>> However this driver supports only up to eMMC 5.0 since the command queue
>>>> feature is not included (yet) in the driver.
>>>>
>>>> [gregory.clement@free-electrons.com:
>>>>  - reformulate commit log
>>>>  - overload the sdhci_set_uhs_signaling function instead of using a quirk
>>>>  - fix a kconfig dependency
>>>>  - remove dead code]
>>>>
>>>> Signed-off-by: Victor Gu <xigu@marvell.com>
>>>> Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
>>>> ---
>>>>  drivers/mmc/host/Kconfig       |   10 +
>>>>  drivers/mmc/host/Makefile      |    1 +
>>>>  drivers/mmc/host/sdhci-xenon.c | 1164 ++++++++++++++++++++++++++++++++++++++++
>>>>  3 files changed, 1175 insertions(+)
>>>>  create mode 100644 drivers/mmc/host/sdhci-xenon.c
>>>>
>>>
>>> <SNIP>
>>>
>>>> diff --git a/drivers/mmc/host/sdhci-xenon.c b/drivers/mmc/host/sdhci-xenon.c
>>>> new file mode 100644
>>>> index 000000000000..43c06db95872
>>>> --- /dev/null
>>>> +++ b/drivers/mmc/host/sdhci-xenon.c
>>>
>>> <SNIP>
>>>
>>>> +static int sdhci_xenon_delay_adj_test(struct sdhci_host *host,
>>>> +           struct mmc_card *card, unsigned int delay,
>>>> +           bool invert, bool phase)
>>>> +{
>>>> +   int ret;
>>>> +   struct mmc_card *oldcard;
>>>> +
>>>> +   sdhci_xenon_set_fix_delay(host, delay, invert, phase);
>>>> +
>>>> +   /*
>>>> +    * If the card is not yet associated to the host, we
>>>> +    * temporally do it
>>>> +    */
>>>> +   oldcard = card->host->card;
>>>> +   if (!oldcard)
>>>> +           card->host->card = card;
>>>> +   ret =  card_alive(card);
>>>
>>> This looks like an abuse of bus_ops->alive().  You will need to get
>>> agreement with Ulf how to handle this.  I will wait for Ulf's comments
>>> before reviewing this patch set further.
>>
>> Actually I modified this part of the driver to use
>> bus_ops->alive(). Initially, the alive() code was more or less copied
>> and paste from the mmc core with ugly include from mmc_ops.h and
>> sdio_ops.h to make it work. I find it cleaner to directly access the
>> alive() function.
>>
>> Could you explain why it is an abuse of  bus_ops->alive()?

Because it's an internal callback to be used only by the mmc core.

>
> bus_ops->alive() is used to determine if the card is present and able to
> respond.  You seem to be using it for a different purpose.  I will wait for
> Ulf's comments.
>

I looked briefly at your code, which uses the ->alive() ops. Indeed
it's a workaround which I cannot accept.

Could you elaborate why you need to send a CMD13 from your host driver?

It's the responsibility of the mmc core to know/implement the
(e)MMC/SD/SDIO protocols. Is there something missing in core to be
able to support your host driver?

Kind regards
Uffe
