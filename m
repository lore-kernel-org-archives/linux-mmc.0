From: "Nath, Arindam" <Arindam.Nath@amd.com>
Subject: mmc/sdhci: system hangs during suspend with SD card mounted
Date: Sun, 1 Jan 2012 11:39:15 -0600
Message-ID: <6C03668EAF45B747AF947A1603D1B3000233315D9A@SAUSEXMBP01.amd.com>
References: <0A4227FEF76DD746B4FA33CAA4AF3C7B0452B7F0@SAUSEXMBP01.amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from ch1ehsobe002.messaging.microsoft.com ([216.32.181.182]:46320
	"EHLO ch1outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750925Ab2AARjQ convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Sun, 1 Jan 2012 12:39:16 -0500
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: 'Andrei Warkentin' <andreiw@motorola.com>
Cc: "'chuanxiao.dong@intel.com'" <chuanxiao.dong@intel.com>, "'viresh.kumar@st.com'" <viresh.kumar@st.com>, "'linux-mmc@vger.kernel.org'" <linux-mmc@vger.kernel.org>

Hi Andrei,

I found that this issue is still there in the latest kernel. It has been pending since quite some time now. The one liner patch submitted by Chuanxiao some time back actually fixed the issue for me too, but if you have a better solution, can you post it?

Thanks,
Arindam

