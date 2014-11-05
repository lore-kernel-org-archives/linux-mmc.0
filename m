From: Meng Wang <meng@tupleapes.com>
Subject: userspace interface of emmc reliable write
Date: Wed, 5 Nov 2014 17:51:21 -0500
Message-ID: <CAP3VVE3ee_uuPV2gGCsafXZ-w0opn0Zt04MVjvNT5M5K8eLkhw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-ob0-f175.google.com ([209.85.214.175]:56388 "EHLO
	mail-ob0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750879AbaKEWvV (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 5 Nov 2014 17:51:21 -0500
Received: by mail-ob0-f175.google.com with SMTP id gq1so1427359obb.34
        for <linux-mmc@vger.kernel.org>; Wed, 05 Nov 2014 14:51:21 -0800 (PST)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org

Hello everyone,
I have an arndale board which equips with KLM4G1FE3B-B001 emmc chip.
According to the datasheet, it's compatible with emmc 4.1 spec and
support reliable write. I want to measure the reliable write
performance but I didn't find the user space interface. Could anyone
give me some suggestions? Thanks in advance.

Best Regards,
WM
