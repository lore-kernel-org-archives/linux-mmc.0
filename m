From: ludovic.desroches@atmel.com
Subject: [PATCH 0/3] atmel-mci fixes
Date: Wed, 21 Mar 2012 16:41:20 +0100
Message-ID: <1332344483-3915-1-git-send-email-ludovic.desroches@atmel.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from newsmtp5.atmel.com ([204.2.163.5]:55980 "EHLO
	sjogate2.atmel.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752347Ab2CUNm2 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 21 Mar 2012 09:42:28 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: nicolas.ferre@atmel.com, ludovic.desroches@atmel.com, plagnioj@jcrosoft.com

Hi,

The following patches provide some fixes for atmel-mci driver:
- data timeout calculation was not correct and can cause serious issues when
using a rootfs on the sd card.
- the r/w proof features is available only from 2xx hsmci version
- supports for odd clock dividers available from 5xx hsmci version

Regards

Ludovic

