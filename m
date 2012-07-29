From: "Asutosh Das" <asutoshd@codeaurora.org>
Subject: RE: Data CRC error in eMMC
Date: Sun, 29 Jul 2012 11:43:42 +0530
Message-ID: <003901cd6d51$5097da00$f1c78e00$@codeaurora.org>
References: <loom.20120727T101420-949@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from wolverine01.qualcomm.com ([199.106.114.254]:32869 "EHLO
	wolverine01.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752442Ab2G2GNs (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sun, 29 Jul 2012 02:13:48 -0400
In-Reply-To: <loom.20120727T101420-949@post.gmane.org>
Content-language: en-us
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: 'jyothishree' <jyothi281@gmail.com>, linux-mmc@vger.kernel.org

>> I am getting data CRC error for CMD25 during suspend mode.
Try checking if the voltage supplied to card is correct after resuming.

Thanks
Asutosh

--
Sent by consultant of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum


-----Original Message-----
From: linux-mmc-owner@vger.kernel.org
[mailto:linux-mmc-owner@vger.kernel.org] On Behalf Of jyothishree
Sent: Friday, July 27, 2012 1:49 PM
To: linux-mmc@vger.kernel.org
Subject: Data CRC error in eMMC

Hello,
I am getting data CRC error for CMD25 during suspend mode. 
because of this eMMC error, partition is mapped as read only and system
hangs.
pease let me know how to approach to fix this issue.


--
To unsubscribe from this list: send the line "unsubscribe linux-mmc" in the
body of a message to majordomo@vger.kernel.org More majordomo info at
http://vger.kernel.org/majordomo-info.html

