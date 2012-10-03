From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH 1/2] mmc: dw_mmc: use __devinit_p macro for .remove()
Date: Wed, 03 Oct 2012 16:43:07 +0300
Message-ID: <1349271787.13371.191.camel@smile>
References: <1349270797-19189-1-git-send-email-andriy.shevchenko@linux.intel.com>
	 <CAGxe1ZHF--qR68A4PGBwmFe85DZUK3gxQWE+05PT9yKBUWOPrg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:35150 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755913Ab2JCNnN convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 3 Oct 2012 09:43:13 -0400
In-Reply-To: <CAGxe1ZHF--qR68A4PGBwmFe85DZUK3gxQWE+05PT9yKBUWOPrg@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Girish K S <girish.shivananjappa@linaro.org>
Cc: Chris Ball <cjb@laptop.org>, linux-mmc@vger.kernel.org

On Wed, 2012-10-03 at 22:41 +0900, Girish K S wrote: 
> its  __devexit_p not  __devinit_p
True. Thanks for catching this typo.


-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
