From: Richard Ash <richardashaudacity@googlemail.com>
Subject: Re: 'error -110 sending stop command' on Zynq platform
Date: Thu, 14 Apr 2016 14:52:27 +0100
Message-ID: <CACOFwamDP=pa=C8veOOQQ-FOKhj_MbjBXgmGqKSToMBYEeMMJQ@mail.gmail.com>
References: <CACOFwa=KnacTNDvsTcMzj4_0YCu8uADp3hrxFG7RDK+jLDCing@mail.gmail.com>
	<CACOFwanA-Bx6GYaJLRUAfwgXSxDkX55yGUbFzCTMovCgSZmQ_A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-ob0-f169.google.com ([209.85.214.169]:34645 "EHLO
	mail-ob0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754518AbcDNNw2 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 14 Apr 2016 09:52:28 -0400
Received: by mail-ob0-f169.google.com with SMTP id bg3so48827636obb.1
        for <linux-mmc@vger.kernel.org>; Thu, 14 Apr 2016 06:52:28 -0700 (PDT)
In-Reply-To: <CACOFwanA-Bx6GYaJLRUAfwgXSxDkX55yGUbFzCTMovCgSZmQ_A@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Linux MMC / SD subsystem <linux-mmc@vger.kernel.org>

On 14 April 2016 at 14:20, Richard Ash
<richardashaudacity@googlemail.com> wrote:
> On 13 April 2016 at 12:40, Richard Ash
> <richardashaudacity@googlemail.com> wrote:
>
> I have now repeated the test using kernel 4.5.1 from kernel.org, which
> supports enough hardware to get a serial console and test the SD card.
> I am seeing effectively the same error
>
>  mmcblk0: error -110 sending stop command, original cmd response
> 0x900, card status 0x400e00
>
> This is the same message as before, except that the card status value
> is printed wider. However I left the console open after it happened,
> and received the following messages on it, in a block maybe a minute
> or two later:
>
> mmc0: Card stuck in programming state! mmcblk0 card_busy_detect
> mmc0: card never left busy state
> blk_update_request: I/O error, dev mmcblk0, sector 24060
> Buffer I/O error on dev mmcblk0p1, logical block 15868, lost async page write
> blk_update_request: I/O error, dev mmcblk0, sector 24061
> Buffer I/O error on dev mmcblk0p1, logical block 15869, lost async page write
> mmcblk0: error -110 sending status command, retrying
> mmcblk0: error -110 sending status command, retrying
> mmcblk0: error -110 sending status command, aborting
> blk_update_request: I/O error, dev mmcblk0, sector 38551
> Buffer I/O error on dev mmcblk0p1, logical block 30359, lost async page write
>
> Where do I take this from here?

Looking at the code for this, even the first message (error sending
stop command)
is from within mmc_blk_cmd_recovery(). Should I be looking at where this gets
called from as the cause, or is going through mmc_blk_cmd_recovery() considered
normal?

Thanks,

Richard

dmesg output leading up to this was:

sdhci: Secure Digital Host Controller Interface driver
sdhci: Copyright(c) Pierre Ossman
sdhci-pltfm: SDHCI platform and OF driver helper
mmc0: SDHCI controller on e0100000.sdhci [e0100000.sdhci] using ADMA
mmc0: new high speed SDHC card at address 0007
mmcblk0: mmc0:0007 JTRON 7.42 GiB
 mmcblk0: p1
mmc1: SDHCI controller on e0101000.sdhci [e0101000.sdhci] using ADMA
nf_conntrack version 0.5.0 (7997 buckets, 31988 max)
ip_tables: (C) 2000-2006 Netfilter Core Team
NET: Registered protocol family 10
NET: Registered protocol family 17
bridge: automatic filtering via arp/ip/ip6tables has been deprecated.
Update your scripts to load br_netfilter if you need this.
lib80211: common routines for IEEE802.11 drivers
lib80211_crypt: registered algorithm 'NULL'
lib80211_crypt: registered algorithm 'WEP'
lib80211_crypt: registered algorithm 'CCMP'
lib80211_crypt: registered algorithm 'TKIP'
Registering SWP/SWPB emulation handler
sdhci-arasan e0101000.sdhci: card claims to support voltages below defined range
rtc-ds1307 0-0068: setting system clock to 2016-04-14 13:49:52 UTC (1460641792)
mmc1: new high speed SDIO card at address 0001
Freeing unused kernel memory: 260K (405c1000 - 40602000)
random: dd urandom read with 3 bits of entropy available
udc-core: couldn't find an available UDC - added [g_ether] to list of
pending drivers
mmcblk0: error -110 sending stop command, original cmd response 0x900,
card status 0x400e00
random: nonblocking pool is initialized
