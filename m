From: Goldschmidt Simon <sgoldschmidt@de.pepperl-fuchs.com>
Subject: Re: dw_mmc: busy check incomplete?
Date: Fri, 15 Sep 2017 04:38:41 +0000
Message-ID: <FD897F46D140444CAB8DC80B08F0742B0185AAEB0B@PFDE-MX10.EU.P-F.BIZ>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout.pepperl-fuchs.com ([212.21.166.229]:56855 "EHLO
        mailout.pepperl-fuchs.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750720AbdIOEip (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 15 Sep 2017 00:38:45 -0400
Received: from PFDE-CAS1.EU.P-F.BIZ (pfde-cas1.eu.p-f.biz [172.24.5.133])
        by mailout.pepperl-fuchs.com (Postfix) with ESMTP id C0EBD819F6
        for <linux-mmc@vger.kernel.org>; Fri, 15 Sep 2017 06:38:42 +0200 (CEST)
Content-Language: de-DE
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>

On 2017/9/14 09:49, Shawn Lin wrote:
> On 2017/9/14 13:33, Goldschmidt Simon wrote:
>> [..]
>> I'm running 4.9.33-rt23 on a socfpga_cyclone5 with mmc-utils 0.1 (from
>> debian strecth). However, checking the newest versions of both the
>> kernel and mmc-utils, I do not see relevant changes.
> 
> The situation of busy check was bad and all R1b shoule be handled by
> core but not by individual host. dwmmc only handle some special
> fsm busy internally noted by databook but left others for core.
> Some improvement was introduced but I think you backport
> all that for your 4.9 stock kernel if it doesn't contain these:
> 
> mainline:  git log drivers/mmc,
> from commit 20348d1981  ~  e173f8911f091f

Reading the git log, those commits were before 4.9 final and I am
running a stock 4.9.33 (only addition is the rt patch).

I also just tested a clean 4.13.2 (no rt patch) and it shows the same
result. Does that mean the dw_mmc driver handles R1b the wrong way?


Simon
