From: Girish K S <girish.shivananjappa@linaro.org>
Subject: confusion regarding the CMD19 and CMD21 in eMMC/SD card spec
Date: Thu, 15 Sep 2011 17:28:05 +0530
Message-ID: <CAGxe1ZH=mrAdfVR7Uw8mYNAD43BAbW7VGuhA1pN9hbSjTG9HVA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-ww0-f44.google.com ([74.125.82.44]:41529 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933214Ab1IOL6H (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 15 Sep 2011 07:58:07 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, linux-samsung-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Dear all,
             The eMMC 4.5 specification mentions that the CMD21 in
class 2 is a SEND_TUNING BLOCK command. where as the SD card
specification
in the given link says CMD19 in class 2 is the SEND_TUNING_BLOCK
http://www.scribd.com/doc/50685191/53/Figure-4-8-Send-Tuning-Block-Command.
Also the implementation in the drivers/mmc/host/sdhci.c uses the CMD19
as the SEND_TUNING_BLOCK.
Can anybody clarify why there is overlapping in this command number.
May be my understand is wrong.

In the MMC spec the CMD19 is BUS_TEST_W in class 0 and CMD21 is
reserved till eMMC 4.41 version.
But in the SD specification (given link) CMD19 is SEND_TUNING_BLOCK
and CMD21 is reserved.

Thanks and regards
Girish K S
