From: Vincent.Yang <Vincent.Yang@tw.fujitsu.com>
Subject: RE: [PATCH 4/4] mmc: core: hold SD Clock before CMD11 during Signal
Date: Sun, 13 Jul 2014 17:49:22 +0800
Message-ID: <830AC58E49A426478AC39824BC0FA915D8B8F21DDC@fmpitwmsex01.fmpi.sea.css.fujitsu.com>
References: <1405228870-5088-1-git-send-email-Vincent.Yang@tw.fujitsu.com>
 <1405228870-5088-5-git-send-email-Vincent.Yang@tw.fujitsu.com>
 <20140713083014.GK21766@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20140713083014.GK21766@n2100.arm.linux.org.uk>
Content-Language: zh-TW
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: "t.takinishi@jp.fujitsu.com" <t.takinishi@jp.fujitsu.com>, "andy.green@linaro.org" <andy.green@linaro.org>, "arnd@arndb.de" <arnd@arndb.de>, "patches@linaro.org" <patches@linaro.org>, "anton@enomsg.org" <anton@enomsg.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "chris@printf.net" <chris@printf.net>, "jaswinder.singh@linaro.org" <jaswinder.singh@linaro.org>, "mollie.wu@linaro.org" <mollie.wu@linaro.org>, "olof@lixom.net" <olof@lixom.net>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-mmc@vger.kernel.org

>-----Original Message-----
>From: Russell King - ARM Linux [mailto:linux@arm.linux.org.uk]
>On Sun, Jul 13, 2014 at 01:21:10PM +0800, Vincent Yang wrote:
>> Voltage Switch Procedure
>>
>> This patch is to fix an issue found on mb86s7x platforms.
>>
>> [symptom]
>> There are some UHS-1 SD memory cards sometimes cannot be detected correctly,
>> e.g., Transcend 600x SDXC 64GB UHS-1 memory card.
>> During Signal Voltage Switch Procedure, failure to switch is indicated
>> by the card holding DAT[3:0] low.
>>
>> [analysis]
>> According to SD Host Controller Simplified Specification Version 3.00
>> chapter 3.6.1, the Signal Voltage Switch Procedure should be:
>> (1) Check S18A; (2) Issue CMD11; (3) Check CMD 11 response;
>> (4) Stop providing SD clock; (5) Check DAT[3:0] should be 0000b;
>> (6) Set 1.8V Signal Enable; (7) Wait 5ms; (8) Check 1.8V Signal Enable;
>> (9) Provide SD Clock; (10) Wait 1ms; (11) Check DAT[3:0] should be 1111b;
>> (12) error handling
>>
>> With CONFIG_MMC_CLKGATE=y, sometimes there is one more gating/un-gating
>> SD clock between (2) and (3). In this case, some UHS-1 SD cards will hold
>> DAT[3:0] 0000b at (11) and thus fails Signal Voltage Switch Procedure.
>>
>> [solution]
>> By mmc_host_clk_hold() before CMD11, the additional gating/un-gating
>> SD clock between (2) and (3) can be prevented and thus no failure at (11).
>> It has been verified with many UHS-1 SD cards on mb86s7x platforms and
>> works correctly.
>>
>> Signed-off-by: Vincent Yang <Vincent.Yang@tw.fujitsu.com>
>> ---
>>  drivers/mmc/core/core.c | 4 ++--
>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
>> index 7dc0c85..764af63 100644
>> --- a/drivers/mmc/core/core.c
>> +++ b/drivers/mmc/core/core.c
>> @@ -1428,6 +1428,8 @@ int mmc_set_signal_voltage(struct mmc_host *host, int
>signal_voltage, u32 ocr)
>>               pr_warning("%s: cannot verify signal voltage switch\n",
>>                               mmc_hostname(host));
>>
>> +     mmc_host_clk_hold(host);
>> +
>>       cmd.opcode = SD_SWITCH_VOLTAGE;
>>       cmd.arg = 0;
>>       cmd.flags = MMC_RSP_R1 | MMC_CMD_AC;
>> @@ -1438,8 +1440,6 @@ int mmc_set_signal_voltage(struct mmc_host *host, int
>signal_voltage, u32 ocr)
>>
>>       if (!mmc_host_is_spi(host) && (cmd.resp[0] & R1_ERROR))
>>               return -EIO;
>> -
>> -     mmc_host_clk_hold(host);
>
>Your analysis may be correct, but implementation leads something to be
>desired - what happens if we exit the function just above this deleted
>line - returning -EIO ?  Shouldn't there be some releasing of the
>clock hold?

Hi Russell,

Thanks a lot for your kind help and also your review.
I'll fix it in next version.

Best regards,
Vincent Yang

>
>--
>FTTC broadband for 0.8mile line: currently at 9.5Mbps down 400kbps up
>according to speedtest.net.
