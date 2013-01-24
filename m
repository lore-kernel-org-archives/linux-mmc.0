From: Barak Wasserstrom <wbarak@gmail.com>
Subject: device tree support for MMC host OCR mask
Date: Thu, 24 Jan 2013 19:46:05 +0200
Message-ID: <CD273FDE.3764A%wbarak@gmail.com>
References: <S1751919Ab3AXRe0/20130124173426Z+264@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-ee0-f50.google.com ([74.125.83.50]:49950 "EHLO
	mail-ee0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752380Ab3AXRqO (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 24 Jan 2013 12:46:14 -0500
Received: by mail-ee0-f50.google.com with SMTP id e51so4900292eek.9
        for <linux-mmc@vger.kernel.org>; Thu, 24 Jan 2013 09:46:13 -0800 (PST)
In-Reply-To: <S1751919Ab3AXRe0/20130124173426Z+264@vger.kernel.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org

Hi,
Is there a standard support for providing the MMC host OCR mask in the
device tree structure?
I'm using ARM PrimeCell PL180/181 Multimedia Card Interface driver.
In 'mmci_dt_populate_generic_pdata' I cannot see any evidence for parsing
oct mask.
I wonder if I can just add to the function:
 of_property_read_u32(np, "ocr-mask", &pdata->ocr_mask);


Regards,
Barak


