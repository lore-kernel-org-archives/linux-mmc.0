From: Shashidhar Hiremath <shashidharh@vayavyalabs.com>
Subject: A question on IOCTL interface for MMC
Date: Thu, 20 Oct 2011 10:39:00 +0530
Message-ID: <CANYdXnqDYn5-zehsJ9ibviJ7FoofcY=YLUqrROoK8k53v-czNA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:62937 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751869Ab1JTFJB (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 20 Oct 2011 01:09:01 -0400
Received: by iaek3 with SMTP id k3so2971010iae.19
        for <linux-mmc@vger.kernel.org>; Wed, 19 Oct 2011 22:09:00 -0700 (PDT)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <cjb@laptop.org>, J Freyensee <james_p_freyensee@linux.intel.com>, John Calixto <john.calixto@modsystems.com>, linux-mmc@vger.kernel.org

Hi ,
  I am planning to use the existing IOCTL interface for SD/MMC present
in the kernel.
  Since, the IOCTL interface expects a read/write flag , and the MMC
IOCTL is actually an interface to block layer I feel without modifying
the block layer for the support of non-read write commands ,I may not
be able to test the non-read/write commands through the IOCTL
interface .
Is there a way of doing this without modifying block layer ?
--
regards,
Shashidhar Hiremath
