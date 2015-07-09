From: Alexey Brodkin <Alexey.Brodkin@synopsys.com>
Subject: Re: [PATCH] mmc: dw_mmc: handle data blocks > than 4kB if IDMAC is
 used
Date: Thu, 9 Jul 2015 13:04:50 +0000
Message-ID: <1436447090.16269.0.camel@synopsys.com>
References: <1435220707-7250-1-git-send-email-abrodkin@synopsys.com>
	 <559CA38D.10700@samsung.com> <1436345145.2890.4.camel@synopsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-7"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from smtprelay.synopsys.com ([198.182.47.9]:37940 "EHLO
	smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752128AbbGINEz convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 9 Jul 2015 09:04:55 -0400
In-Reply-To: <1436345145.2890.4.camel@synopsys.com>
Content-Language: en-US
Content-ID: <AA702EAFEC3144488C7D9B164C7E05BF@internal.synopsys.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: "jh80.chung@samsung.com" <jh80.chung@samsung.com>
Cc: "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "tgih.jun@samsung.com" <tgih.jun@samsung.com>, "arc-linux-dev@synopsys.com" <arc-linux-dev@synopsys.com>

Hi Jaehoon,

On Wed, 2015-07-08 at 11:45 +-0300, Alexey Brodkin wrote:
+AD4- 
+AD4- Let me know if that description makes sense to you.

I'm wondering if you had a chance to look at my comments and if
those comments make sense or you need more input from me.

-Alexey