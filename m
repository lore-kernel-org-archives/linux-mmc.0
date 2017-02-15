From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH v2 4/4] mmc: host: tmio: fill in response from auto cmd12
Date: Wed, 15 Feb 2017 11:19:19 +0100
Message-ID: <CAPDyKFobQ07u_xUgpm7iQRJkCqVS9_6JvyoTDhqLM-R3qCFeGQ@mail.gmail.com>
References: <20170213180342.26172-1-wsa+renesas@sang-engineering.com>
 <20170213180342.26172-5-wsa+renesas@sang-engineering.com> <HK2PR06MB05484A4141A1A9AC8BE54E00D8580@HK2PR06MB0548.apcprd06.prod.outlook.com>
 <20170214105226.GB1453@katana>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <20170214105226.GB1453@katana>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, Wolfram Sang <wsa+renesas@sang-engineering.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>, Simon Horman <horms+renesas@verge.net.au>
List-Id: linux-mmc@vger.kernel.org

On 14 February 2017 at 11:52, Wolfram Sang <wsa@the-dreams.de> wrote:
> Shimoda-san, Ulf,
>
> On Tue, Feb 14, 2017 at 10:06:47AM +0000, Yoshihiro Shimoda wrote:
>> Hi,
>>
>> > From: Wolfram Sang [mailto:wsa+renesas@sang-engineering.com]
>> > Sent: Tuesday, February 14, 2017 3:04 AM
>> >
>> > After we received the dataend interrupt, R1 response register carries
>> > the value from the automatically generated stop command. Report that
>> > info back to the MMC block layer, so we will be notified in case of e.g.
>> > ECC errors which happened during the last transfer.
>> >
>> > Reviewed-by: Simon Horman <horms+renesas@verge.net.au>
>> > Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
>>
>> I tested this patch with a SD tester (SGDK320).
>> As the commit log, this patch could pass the R1 response. So,
>>
>> Tested-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
>
> Thank you very much for testing!
>
>> However, I think the MMC block layer should check the brq->stop.resp[0]
>> because brq->stop.error should be zero in this case and mmc_blk_cmd_recovery()
>> is not called in mmc_blk_err_check().
>
> I see. Ulf, do you think it makes sense to extend the condition when to
> call mmc_blk_cmd_recovery() with checking if stop.resp[0] has one of the
> R1_* bits set which are marked with 'ex' (and probably 'erx', too)? I
> agree with Shimoda-san, that the core is a good place to do it, since it
> is about parsing the R1 and not the status bits of the host hardware.

The method we use to indicate a stop command error to the mmc core, is
to set ->stop.error in the host driver before completing the request.
Perhaps set it to -EIO or -EILSEQ.

In that way mmc_blk_err_check() sees the error and invokes the
mmc_blk_cmd_recovery() to deal with it (response parsing etc).

Does that work for you?

Kind regards
Uffe
