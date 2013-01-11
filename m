From: Asutosh Das <asutoshd@codeaurora.org>
Subject: Query regarding ADMA descriptor allocation
Date: Fri, 11 Jan 2013 18:01:27 +0530
Message-ID: <50F0061F.6070509@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from wolverine02.qualcomm.com ([199.106.114.251]:34965 "EHLO
	wolverine02.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753137Ab3AKMba (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 11 Jan 2013 07:31:30 -0500
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: drzeus@drzeus.cx, linux-mmc@vger.kernel.org

Hi
In sdhci_add_host function, the number of adma descriptors allocated are 
128 and each descriptor consumes 8 bytes and 1 4byte is added in the end 
like,
kmalloc((128 * 2 + 1) * 4, GFP_KERNEL);

In sdhci_adma_table_pre function, each node in sg-list is iterated and 
in case of a misaligned node, a descriptor is consumed, which means for 
a single sg-node 2 descriptors were consumed. Let's say in a situation, 
where there are multiple unaligned addresses in multiple sg nodes and 
the sg-list length is 128, wouldn't this use up all the 128 descriptors 
long before the entire sg-list is traversed ?




-- 
Sent by a consultant of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.

