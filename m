From: Krishna Konda <kkonda@codeaurora.org>
Subject: Secure Trim vs Discard & Sanitize
Date: Fri, 22 May 2015 11:30:42 -0700
Message-ID: <555F75D2.4020501@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:58855 "EHLO
	smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757125AbbEVSao (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 22 May 2015 14:30:44 -0400
Received: from [10.46.164.83] (i-global254.qualcomm.com [199.106.103.254])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	(Authenticated sender: kkonda@smtp.codeaurora.org)
	by smtp.codeaurora.org (Postfix) with ESMTPSA id 59789141060
	for <linux-mmc@vger.kernel.org>; Fri, 22 May 2015 18:30:43 +0000 (UTC)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>

The eMMC 4.5 and later specifications mention that the "Secure Erase" 
and "Secure Trim" operations are not meant for eMMC 4.5 and later 
devices but the driver still performs those operations on when block 
layer issues a SECDISCARD (or REQ_DISCARD|REQ_SECURE) request.

I dont know why the driver did not move to TRIM + SANITIZE or DISCARD + 
SANITIZE and I could not find any email discussions about this.

I have seen the patches that provide sanitize via ioctls but I am more 
interested if the driver should use the newer commands and should it 
invoke sanitize when performing a secure discard operation..


-- 
Thanks,
Krishna Konda
-----------------------------------------------------------------------
Employee of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
-----------------------------------------------------------------------
