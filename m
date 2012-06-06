From: "Subhash Jadavani" <subhashj@codeaurora.org>
Subject: RE: power class selection fails on 3.5-rc1
Date: Wed, 6 Jun 2012 15:14:48 +0530
Message-ID: <000301cd43c9$05745550$105cfff0$@codeaurora.org>
References: <6008680.IROCjD91iZ@ax5200p> <4FCDFD3E.9020804@stericsson.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from wolverine02.qualcomm.com ([199.106.114.251]:26268 "EHLO
	wolverine02.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752403Ab2FFJox (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 6 Jun 2012 05:44:53 -0400
In-Reply-To: <4FCDFD3E.9020804@stericsson.com>
Content-Language: en-us
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: 'Ulf Hansson' <ulf.hansson@stericsson.com>, 'Marc Dietrich' <marvin24@gmx.de>, Girish K S <girish.shivananjappa@linaro.org>, saugata.das@linaro.org
Cc: linux-mmc@vger.kernel.org

<Girish / Saugata needs to comment on one point>

Comments inline:

> -----Original Message-----
> From: Ulf Hansson [mailto:ulf.hansson@stericsson.com]
> Sent: Tuesday, June 05, 2012 6:06 PM
> To: Marc Dietrich; Subhash Jadavani
> Cc: linux-mmc@vger.kernel.org
> Subject: Re: power class selection fails on 3.5-rc1
> 
> Hi Marc,
> 
> Maybe we can have some input from Subhash on this matter. I believe a
revert
> can be feasible until a working solution exist.
> 
> Kind regards
> Ulf Hansson
> 
> On 06/04/2012 06:35 PM, Marc Dietrich wrote:
> > Hi,
> >
> > somehow I hope this would go away by itself, but it didn't :-( I
> > reported this problem some time ago (see:
> > http://www.mail-archive.com/linux-
> > mmc@vger.kernel.org/msg13688.html ) but got no clear answer or fix.
> >
> > In addition to the information I posted on the thread above, I also
> > dumped the contents of the ext_csd register file (where reg values are
not
> zero):
> >
> > reg       Sandisk         Toshiba
> > 241     10      0x0a    50      0x32
> > 239     0       0x00    51      0x33
> > 238     0       0x00    119     0x77
> > 234     0       0x00    30      0x1e
> > 232     1       0x01    4       0x04
> > 231     21      0x15    21      0x15
> > 230     150     0x96    16      0x10
> > 229     150     0x96    66      0x42
> > 228     1       0x01    7       0x07
> > 226     8       0x08    16      0x10
> > 225     6       0x06    7       0x07
> > 224     4       0x04    8       0x08
> > 223     1       0x01    2       0x02
> > 222     8       0x08    16      0x10
> > 221     16      0x10    1       0x01
> > 220     8       0x08    7       0x07
> > 219     7       0x07    7       0x07
> > 217     16      0x10    17      0x11
> > 215     1       0x01    0       0x00
> > 214     218     0xda    238     0xee
> > 213     160     0xa0    128     0x80
> > 210     10      0x0a    0       0x00
> > 209     10      0x0a    60      0x3c
> > 208     10      0x0a    0       0x00
> > 207     10      0x0a    60      0x3c
> > 206     10      0x0a    0       0x00
> > 205     10      0x0a    30      0x1e
> > 203     0       0x00    51      0x33
> > 202     0       0x00    51      0x33
> > 201     0       0x00    119     0x77
> > 200     0       0x00    119     0x77
> > 196     3       0x03    7       0x07
> > 194     2       0x02    2       0x02
> > 192     5       0x05    5       0x05
> > 185     1       0x01    1       0x01
> > 181     0       0x00    1       0x01
> > 179     0       0x00    1       0x01
> > 175     0       0x00    1       0x01
> > 169     1       0x01    0       0x00
> > 168     0       0x00    2       0x02
> > 160     3       0x03    3       0x03
> > 158     0       0x00    3       0x03
> > 157     237     0xed    186     0xba
> >
> > The second and the third column is from a device with a Sandisk eMCC
> > which works fine, while the last two columns are from a Toshiba eMMC
> > which shows the error. Looking into it, I found that only the Toshiba
> > eMMC specifies a powerclass in registers 203-200 while Sandisk does
> > not, so the powerclass is not changed in the latter case and the problem
> cannot be triggered there.
> >
> > I also attached a boot log with mmc debug enabled. I think there is
> > not much I can do else. Either this eMMC is just bogus and needs
> > blacklisting or there is some problem in the driver code.

I checked the power class specification and MMC core driver handing, I don't
see any issue with it. As you mentioned the PWR_CL_* fields are having
non-zero values which means SWITCH (CMD6) will be sent to change the
POWER_CLASS and from the logs you have attached, this switch command tries
to set the POWER_CLASS to 3 which is resulting in SWITCH_ERROR in card and
that's why it fails.

If the PWR_CL_* fields are 0s (that's the case with SanDisk eMMC as you
mentioned), SWITCH(cmd6) is not sent to the card.

I was trying to check analyze more from logs and the above EXT_CSD fields
for Toshiba card.

EXT_CSD[203] => PWR_CL_26_360 => 0x33
EXT_CSD[202] => PWR_CL_52_360 => 0x33
EXT_CSD[201] => PWR_CL_26_195 => 0x77
EXT_CSD[200] => PWR_CL_52_195 => 0x77

>> [    3.842382] mmc1: clock 48000000Hz busmode 2 powermode 2 cs 0 Vdd 20
width 0 timing 1
Logs shows that clock = 48MHz, bus_width = 8-Bit, SDR mode, VDD = High
voltage range. This would mean power class for this configuration will be in
higher nibble of PWR_CL_52_360 field (EXT_CSD[202]) which is 0x3.

>> [    3.842390] mmc1: starting CMD6 arg 03bb0301 flags 0000049d
"arg" field from this logs show that we are trying to set the POWER_CLASS
(EXT_CSD[187]) field to value 0x3 which is resulting in switch error which
ideally shouldn't.

Just for experiment, can we hack the value set to POWER_CLASS field to 0x7
instead of 0x3? If this doesn't work, you may try other values (starting
from 1 till 15) to see setting any of the non-zero value succeeds or not.

diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
index 2d4a4b7..b26913a 100644
--- a/drivers/mmc/core/mmc.c
+++ b/drivers/mmc/core/mmc.c
@@ -713,7 +713,7 @@ static int mmc_select_powerclass(struct mmc_card *card,
        if (pwrclass_val > 0) {
                err = mmc_switch(card, EXT_CSD_CMD_SET_NORMAL,
                                 EXT_CSD_POWER_CLASS,
-                                pwrclass_val,
+                                0x7,
                                 card->ext_csd.generic_cmd6_time);
        }


> >
> > I hope this problem can be fixed or if it can't, I hope that commit
> > 3d93576e
> > (mmc: core: skip card initialization if power class selection fails)
> > is reverted until the issues are sorted out.

3d93576e is really not the issue here. Reverting that patch is just a bad
workaround to the problem. We should actually try to find why exactly
setting the POWER_CLASS field is failing?

Originally, Girish had added power class selection base patch. I am not sure
whether he ever got a change to test eMMC cards which expose the non-zero
values in PWR_CL_* fields.
Girish, Can you please comment on what type of testing was done at that
time?

> >
> > Greetings,
> >
> > 	Marc


