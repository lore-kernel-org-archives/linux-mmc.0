From: Ulf Hansson <ulf.hansson@stericsson.com>
Subject: Re: power class selection fails on 3.5-rc1
Date: Tue, 5 Jun 2012 14:36:14 +0200
Message-ID: <4FCDFD3E.9020804@stericsson.com>
References: <6008680.IROCjD91iZ@ax5200p>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from eu1sys200aog119.obsmtp.com ([207.126.144.147]:44962 "EHLO
	eu1sys200aog119.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751779Ab2FEMgY (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 5 Jun 2012 08:36:24 -0400
In-Reply-To: <6008680.IROCjD91iZ@ax5200p>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Marc Dietrich <marvin24@gmx.de>, Subhash Jadavani <subhashj@codeaurora.org>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>

Hi Marc,

Maybe we can have some input from Subhash on this matter. I believe a 
revert can be feasible until a working solution exist.

Kind regards
Ulf Hansson

On 06/04/2012 06:35 PM, Marc Dietrich wrote:
> Hi,
>
> somehow I hope this would go away by itself, but it didn't :-( I reported this
> problem some time ago (see: http://www.mail-archive.com/linux-
> mmc@vger.kernel.org/msg13688.html ) but got no clear answer or fix.
>
> In addition to the information I posted on the thread above, I also dumped the
> contents of the ext_csd register file (where reg values are not zero):
>
> reg       Sandisk         Toshiba
> 241     10      0x0a    50      0x32
> 239     0       0x00    51      0x33
> 238     0       0x00    119     0x77
> 234     0       0x00    30      0x1e
> 232     1       0x01    4       0x04
> 231     21      0x15    21      0x15
> 230     150     0x96    16      0x10
> 229     150     0x96    66      0x42
> 228     1       0x01    7       0x07
> 226     8       0x08    16      0x10
> 225     6       0x06    7       0x07
> 224     4       0x04    8       0x08
> 223     1       0x01    2       0x02
> 222     8       0x08    16      0x10
> 221     16      0x10    1       0x01
> 220     8       0x08    7       0x07
> 219     7       0x07    7       0x07
> 217     16      0x10    17      0x11
> 215     1       0x01    0       0x00
> 214     218     0xda    238     0xee
> 213     160     0xa0    128     0x80
> 210     10      0x0a    0       0x00
> 209     10      0x0a    60      0x3c
> 208     10      0x0a    0       0x00
> 207     10      0x0a    60      0x3c
> 206     10      0x0a    0       0x00
> 205     10      0x0a    30      0x1e
> 203     0       0x00    51      0x33
> 202     0       0x00    51      0x33
> 201     0       0x00    119     0x77
> 200     0       0x00    119     0x77
> 196     3       0x03    7       0x07
> 194     2       0x02    2       0x02
> 192     5       0x05    5       0x05
> 185     1       0x01    1       0x01
> 181     0       0x00    1       0x01
> 179     0       0x00    1       0x01
> 175     0       0x00    1       0x01
> 169     1       0x01    0       0x00
> 168     0       0x00    2       0x02
> 160     3       0x03    3       0x03
> 158     0       0x00    3       0x03
> 157     237     0xed    186     0xba
>
> The second and the third column is from a device with a Sandisk eMCC which
> works fine, while the last two columns are from a Toshiba eMMC which shows the
> error. Looking into it, I found that only the Toshiba eMMC specifies a
> powerclass in registers 203-200 while Sandisk does not, so the powerclass is
> not changed in the latter case and the problem cannot be triggered there.
>
> I also attached a boot log with mmc debug enabled. I think there is not much I
> can do else. Either this eMMC is just bogus and needs blacklisting or there is
> some problem in the driver code.
>
> I hope this problem can be fixed or if it can't, I hope that commit 3d93576e
> (mmc: core: skip card initialization if power class selection fails) is
> reverted until the issues are sorted out.
>
> Greetings,
>
> 	Marc

