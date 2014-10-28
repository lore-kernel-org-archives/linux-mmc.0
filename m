From: Mike Looijmans <mike.looijmans@topic.nl>
Subject: Re: [PATCH 2/2] mmc/host/sdhci-of-arasan.c: Skip EPROBE_DEFER error messages
Date: Tue, 28 Oct 2014 08:53:20 +0100
Message-ID: <1414482801-3773-1-git-send-email-mike.looijmans@topic.nl>
References: <CAPDyKFpuiPqZ+5h-SS2-7XeVVh4J2v3SQr=RtjaTZw=0=bXABw@mail.gmail.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from atl4mhfb03.myregisteredsite.com ([209.17.115.61]:39084 "EHLO
	atl4mhfb03.myregisteredsite.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1760923AbaJ1Hxb (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 28 Oct 2014 03:53:31 -0400
Received: from atl4mhob17.myregisteredsite.com (atl4mhob17.myregisteredsite.com [209.17.115.110])
	by atl4mhfb03.myregisteredsite.com (8.14.4/8.14.4) with ESMTP id s9S7rSKn031767
	for <linux-mmc@vger.kernel.org>; Tue, 28 Oct 2014 03:53:29 -0400
Received: from mailpod.hostingplatform.com ([10.30.71.203])
	by atl4mhob17.myregisteredsite.com (8.14.4/8.14.4) with ESMTP id s9S7rQsZ031448
	for <linux-mmc@vger.kernel.org>; Tue, 28 Oct 2014 03:53:26 -0400
In-Reply-To: <CAPDyKFpuiPqZ+5h-SS2-7XeVVh4J2v3SQr=RtjaTZw=0=bXABw@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, michal.simek@xilinx.com, chris@printf.net, ulf.hansson@linaro.org

As discussed here, I'll post a new patch which simply removes the error
messages.

