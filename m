From: Richard Ash <richardashaudacity@googlemail.com>
Subject: SD cards which hang - card problem or controller bug?
Date: Wed, 20 Apr 2016 18:09:04 +0100
Message-ID: <CACOFwa=Uk5Zszso4DQbU6yWCzQxGp7c37dyCVpm300Y0e3c7AQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-ob0-f169.google.com ([209.85.214.169]:36294 "EHLO
	mail-ob0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750807AbcDTRJG (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 20 Apr 2016 13:09:06 -0400
Received: by mail-ob0-f169.google.com with SMTP id j9so35354809obd.3
        for <linux-mmc@vger.kernel.org>; Wed, 20 Apr 2016 10:09:05 -0700 (PDT)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Linux MMC / SD subsystem <linux-mmc@vger.kernel.org>

Following up on my previous thread ('error -110 sending stop command'
on Zynq platform), I have now done a lot more testing across multiple
cards and devices. In summary:
* Most cards work fine in my custom board and and a ZedBoard, both
using Zynq / sdhci controller
* The Phison cards I have been buying do not work reliably in either
of these devices
* The Phison cards do work reliably when put into a laptop using a
Realtek RTS5229 PCI Express Card Reader / rtsx_pci

Because of the latter, I can't easily reject the cards as defective,
because they work fine in some devices. Also, I don't know what I
should get to have working cards in the future, as all of the ones I
have which work are consumer cards and never the same twice when you
buy them.

This leaves me with two questions:
1. Does the rtsx_pci driver go through the mmc sub-system, or do I
need to go and query somewhere else for that?
2. Is it possible work out from the fact that the card works reliably
with this driver, but not with sdhci, which is going wrong? Should I
be comparing a list of quirks applied somewhere (I couldn't find one)?

Thanks for any input to this,

Richard Ash
