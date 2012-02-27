From: Daniel Palmer <me@danielpalmer.co.uk>
Subject: Re: atmel-mci causing oops?
Date: Mon, 27 Feb 2012 10:57:28 +0900
Message-ID: <201202271057.28579.me@danielpalmer.co.uk>
References: <201202270949.23934.me@danielpalmer.co.uk> <003401ccf4ef$67e3b880$37ab2980$%jun@samsung.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from tomato.cardboardbox.org.uk ([174.143.157.65]:44804 "EHLO
	tomato.cardboardbox.org.uk" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753569Ab2B0B5i (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sun, 26 Feb 2012 20:57:38 -0500
In-Reply-To: <003401ccf4ef$67e3b880$37ab2980$%jun@samsung.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Seungwon Jeon <tgih.jun@samsung.com>
Cc: linux-mmc@vger.kernel.org

On Monday, February 27, 2012 10:30:35 AM Seungwon Jeon wrote:
> Hi.
> 
> CONFIG_HIGHMEM is enabled in 3.3rc5?
> I think your problem is similar to the following commit.
> "mmc: dw_mmc: Fix PIO mode with support of highmem"(fc66a7bb13806c0)
> 

Hi,

Thank you for your input. CONFIG_HIGHMEM isn't enabled, but CONFIG_SPARSEMEM 
is (The SAM9G45 has two banks of RAM with a hole in the middle). Could that be 
an issue? Without it I can only access 128MB of 256MB of RAM, but I can test 
if it works.

Cheers,

Daniel
