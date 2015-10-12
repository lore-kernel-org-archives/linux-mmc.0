From: Muni Sekhar <munisekharrms@gmail.com>
Subject: mmc_test.ko usage
Date: Mon, 12 Oct 2015 11:25:37 +0530
Message-ID: <CAHhAz+iGUga6o+zatkew8uqBi+aJpHnpetGx393Fc_sC4YQhxA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-io0-f180.google.com ([209.85.223.180]:34730 "EHLO
	mail-io0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750811AbbJLFzi (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 12 Oct 2015 01:55:38 -0400
Received: by iow1 with SMTP id 1so142923823iow.1
        for <linux-mmc@vger.kernel.org>; Sun, 11 Oct 2015 22:55:37 -0700 (PDT)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc <linux-mmc@vger.kernel.org>

Hi ,


I tried to use the MMC host test driver (mmc_test.ko) for testing SD
Host controller hardware. When I load the driver I noticed that
mmc_test_probe() not getting called.

Could anyone specify the exact usage of mmc_test.ko?


-- 
Thanks,
Sekhar
