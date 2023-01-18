Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D361AC38147
	for <linux-mmc@archiver.kernel.org>; Wed, 18 Jan 2023 21:25:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230519AbjARVZP (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 18 Jan 2023 16:25:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231193AbjARVZI (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 18 Jan 2023 16:25:08 -0500
Received: from longisland.snafu.de (longisland.snafu.de [IPv6:2001:1560:3:255::153])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A057630A6
        for <linux-mmc@vger.kernel.org>; Wed, 18 Jan 2023 13:25:05 -0800 (PST)
X-Trace: 4c7c73656261737469616e2e6b6c6f736b6140736e6166752e64657c38342e3233
        2e3235342e3230367c3170494676572d3030305047792d464d7c31363734303737
        303938
Received: from longisland.snafu.de ([10.153.10.19] helo=localhost)
        by longisland.snafu.de with esmtpa (Exim 4.94.2) 
        id 1pIFvW-000PGy-FM; Wed, 18 Jan 2023 22:24:59 +0100
MIME-Version: 1.0
Date:   Wed, 18 Jan 2023 22:24:58 +0100
From:   sebastian.kloska@snafu.de
To:     adrian.hunter@intel.com, riteshh@codeaurora.org,
        asutoshd@codeaurora.org
Cc:     linux-mmc@vger.kernel.org
Subject: Regression 5.14.21 vs 5.15.1: mmc blocked: mmc0: cqhci: timeout for
 tag #
User-Agent: Roundcube Webmail/1.4.13
Message-ID: <c1214ad81df49a314bd4863751de1a45@snafu.de>
X-Sender: sebastian.kloska@snafu.de
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-VISP-ShouldScan: 1
X-VISP-Virus-Check: clean
X-VISP-Spam-Score: 0.7 (/)
X-VISP-Spam-Report: This message has been scanned on "longisland.snafu.de"
 to identify if it is considered spam or not.
 Contact the support hotline for details.
 Content analysis details:   (0.7 points)
  pts rule name              description
 ---- ---------------------- --------------------------------------------------
  0.5 JMQ_SPF_NEUTRAL        ASKDNS: SPF set to ?all
                             [snafu.de TXT:v=spf1 mx ip4:84.23.254.128/25]
 [ip6:2001:1560:3:255::/64 ip6:2001:1560:3:254::/64 ip4:213.73.113.34/32 ip6:2001:1560:a000:2:50:ff:fe00:27ed/128 include:_spf.snafu.de ?all]
 -1.0 ALL_TRUSTED            Passed through trusted hosts only via SMTP
  0.1 TW_QC                  BODY: Odd Letter Triples with QC
  0.1 TW_XF                  BODY: Odd Letter Triples with XF
  0.0 KAM_DMARC_STATUS       Test Rule for DKIM or SPF Failure with Strict
                             Alignment
  0.8 KAM_ASCII_DIVIDERS     Email that uses ascii formatting dividers and
                              possible spam tricks
  0.2 KAM_DMARC_NONE         DKIM has Failed or SPF has failed on the message
                             and the domain has no DMARC policy
X-VISP-Spam-Max-Score: +++++
X-SA-Exim-Connect-IP: 84.23.254.206
X-SA-Exim-Mail-From: sebastian.kloska@snafu.de
X-SA-Exim-Scanned: No (on longisland.snafu.de); SAEximRunCond expanded to false
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Hi,

Hardware: Acer Swift-1 SF114-34-P6U1
SD Host controller: Intel Corporation Device 4dc4 (rev 01) 8086:4dc4
eMMC: Kingston A29128

* A couple of seconds after boot access to the eMMC is completely
   blocked. Can be triggered by extensive I/O (e.g, with badblocks -w)

* Tested with stable branch linux-5.14.21 vs. linux-5.15.1
   Latest highest version including the bug is a fedora 6.1.6

* Spiked the code with a lot of pr_debug messages. As a side effect the 
driver
   seems to be much more stable, so to me it appears like a timing issue 
where
   the driver fails to wait for a specific state change which seems to 
appear
   less often when  slowed down by logging

* Would love to have a decent reference documentation to the SD 
Controller
   especially a detailed description of the behavior of the register map 
in
  mmc/host/cqhci.h All intel documents I could find seem to describe
  similar but not quite identical register maps

Regards

Sebastian

* dmesg

[  347.583082] mmc0: cqhci: timeout for tag 3, qcnt 4
[  347.583086] mmc0: cqhci: ============ CQHCI REGISTER DUMP ===========
[  347.583114] mmc0: cqhci: Caps:      0x000030c0 | Version:  0x00000510
[  347.583117] mmc0: cqhci: Config:    0x00001101 | Control:  0x00000000
[  347.583120] mmc0: cqhci: Int stat:  0x00000000 | Int enab: 0x00000016
[  347.583123] mmc0: cqhci: Int sig:   0x00000016 | Int Coal: 0x00000000
[  347.583157] mmc0: cqhci: TDL base:  0x7c2b5000 | TDL up32: 0x00000001
[  347.583160] mmc0: cqhci: Doorbell:  0x0000000f | TCN:      0x00000000
[  347.583163] mmc0: cqhci: Dev queue: 0x00000008 | Dev Pend: 0x00000008
[  347.583166] mmc0: cqhci: Task clr:  0x00000000 | SSC1:     0x00010008
[  347.583169] mmc0: cqhci: SSC2:      0x00000001 | DCMD rsp: 0x00000800
[  347.583172] mmc0: cqhci: RED mask:  0xfdf9a080 | TERRI:    0x00000000
[  347.583175] mmc0: cqhci: Resp idx:  0x0000002f | Resp arg: 0x00000900
[  347.583176] mmc0: sdhci: ============ SDHCI REGISTER DUMP ===========
[  347.583182] mmc0: sdhci: Sys addr:  0x00000080 | Version:  0x00001002
[  347.583185] mmc0: sdhci: Blk size:  0x00000200 | Blk cnt:  0x00000070
[  347.583188] mmc0: sdhci: Argument:  0x00030000 | Trn mode: 0x00000023
[  347.583191] mmc0: sdhci: Present:   0x1fff0106 | Host ctl: 0x0000003c
[  347.583194] mmc0: sdhci: Power:     0x0000000b | Blk gap:  0x00000080
[  347.583197] mmc0: sdhci: Wake-up:   0x00000000 | Clock:    0x00000007
[  347.583200] mmc0: sdhci: Timeout:   0x0000000e | Int stat: 0x00000000
[  347.583203] mmc0: sdhci: Int enab:  0x02ff4000 | Sig enab: 0x02ff4000
[  347.583206] mmc0: sdhci: ACmd stat: 0x00000000 | Slot int: 0x00000000
[  347.583209] mmc0: sdhci: Caps:      0x546ec881 | Caps_1:   0x80000807
[  347.583212] mmc0: sdhci: Cmd:       0x00002f3a | Max curr: 0x00000000
[  347.583214] mmc0: sdhci: Resp[0]:   0x00000900 | Resp[1]:  0x00000000
[  347.583217] mmc0: sdhci: Resp[2]:   0x00000000 | Resp[3]:  0x00000000
[  347.583219] mmc0: sdhci: Host ctl2: 0x0000000d
[  347.583223] mmc0: sdhci: ADMA Err:  0x00000000 | ADMA Ptr: 
0x000000011eef1218
[  347.583224] mmc0: sdhci: ============================================
[  347.583229] mmc0: running CQE recovery
[  347.690108] mmc0: Reset 0x2 never completed.
[  347.690109] mmc0: sdhci: ============ SDHCI REGISTER DUMP ===========
[  347.690115] mmc0: sdhci: Sys addr:  0x00000080 | Version:  0x00001002
[  347.690118] mmc0: sdhci: Blk size:  0x00000200 | Blk cnt:  0x00000070
[  347.690121] mmc0: sdhci: Argument:  0x00030000 | Trn mode: 0x00000023
[  347.690124] mmc0: sdhci: Present:   0x1fff0106 | Host ctl: 0x0000003c
[  347.690127] mmc0: sdhci: Power:     0x0000000b | Blk gap:  0x00000080
[  347.690130] mmc0: sdhci: Wake-up:   0x00000000 | Clock:    0x00000007
[  347.690133] mmc0: sdhci: Timeout:   0x0000000e | Int stat: 0x00000000
[  347.690136] mmc0: sdhci: Int enab:  0x00ff0003 | Sig enab: 0x00ff0003
[  347.690139] mmc0: sdhci: ACmd stat: 0x00000000 | Slot int: 0x00000000
[  347.690141] mmc0: sdhci: Caps:      0x546ec881 | Caps_1:   0x80000807
[  347.690144] mmc0: sdhci: Cmd:       0x00002f3a | Max curr: 0x00000000
[  347.690147] mmc0: sdhci: Resp[0]:   0x00000900 | Resp[1]:  0x00000000
[  347.690150] mmc0: sdhci: Resp[2]:   0x00000000 | Resp[3]:  0x00000000
[  347.690152] mmc0: sdhci: Host ctl2: 0x0000000d
[  347.690156] mmc0: sdhci: ADMA Err:  0x00000000 | ADMA Ptr: 
0x000000011eef1218
[  347.690157] mmc0: sdhci: ============================================
[  347.790190] mmc0: Reset 0x4 never completed.
[  347.790191] mmc0: sdhci: ============ SDHCI REGISTER DUMP ===========
[  347.790193] mmc0: sdhci: Sys addr:  0x00000080 | Version:  0x00001002
[  347.790196] mmc0: sdhci: Blk size:  0x00000200 | Blk cnt:  0x00000070
[  347.790199] mmc0: sdhci: Argument:  0x00030000 | Trn mode: 0x00000023
[  347.790202] mmc0: sdhci: Present:   0x1fff0106 | Host ctl: 0x0000003c
[  347.790205] mmc0: sdhci: Power:     0x0000000b | Blk gap:  0x00000080
[  347.790208] mmc0: sdhci: Wake-up:   0x00000000 | Clock:    0x00000007
[  347.790211] mmc0: sdhci: Timeout:   0x0000000e | Int stat: 0x00000000
[  347.790213] mmc0: sdhci: Int enab:  0x00ff0003 | Sig enab: 0x00ff0003
[  347.790216] mmc0: sdhci: ACmd stat: 0x00000000 | Slot int: 0x00000000
[  347.790219] mmc0: sdhci: Caps:      0x546ec881 | Caps_1:   0x80000807
[  347.790222] mmc0: sdhci: Cmd:       0x00002f3a | Max curr: 0x00000000
[  347.790225] mmc0: sdhci: Resp[0]:   0x00000900 | Resp[1]:  0x00000000
[  347.790228] mmc0: sdhci: Resp[2]:   0x00000000 | Resp[3]:  0x00000000
[  347.790230] mmc0: sdhci: Host ctl2: 0x0000000d
[  347.790234] mmc0: sdhci: ADMA Err:  0x00000000 | ADMA Ptr: 
0x000000011eef1218
[  347.790234] mmc0: sdhci: ============================================
[  347.803056] mmc0: Controller never released inhibit bit(s).
[  347.803058] mmc0: sdhci: ============ SDHCI REGISTER DUMP ===========
[  347.803077] mmc0: sdhci: Sys addr:  0x00000080 | Version:  0x00001002
[  347.803080] mmc0: sdhci: Blk size:  0x00000200 | Blk cnt:  0x00000070
[  347.803083] mmc0: sdhci: Argument:  0x00030000 | Trn mode: 0x00000023
[  347.803086] mmc0: sdhci: Present:   0x1fff0106 | Host ctl: 0x0000003c
[  347.803089] mmc0: sdhci: Power:     0x0000000b | Blk gap:  0x00000080
[  347.803092] mmc0: sdhci: Wake-up:   0x00000000 | Clock:    0x00000007
[  347.803095] mmc0: sdhci: Timeout:   0x0000000e | Int stat: 0x00000000
[  347.803098] mmc0: sdhci: Int enab:  0x00ff0003 | Sig enab: 0x00ff0003
[  347.803101] mmc0: sdhci: ACmd stat: 0x00000000 | Slot int: 0x00000000
[  347.803103] mmc0: sdhci: Caps:      0x546ec881 | Caps_1:   0x80000807
[  347.803106] mmc0: sdhci: Cmd:       0x00002f3a | Max curr: 0x00000000
[  347.803109] mmc0: sdhci: Resp[0]:   0x00000900 | Resp[1]:  0x00000000
[  347.803112] mmc0: sdhci: Resp[2]:   0x00000000 | Resp[3]:  0x00000000
[  347.803114] mmc0: sdhci: Host ctl2: 0x0000000d
[  347.803118] mmc0: sdhci: ADMA Err:  0x00000000 | ADMA Ptr: 
0x000000011eef1218
[  347.803119] mmc0: sdhci: ============================================
  --

-- 
