From: Asutosh Das <asutoshd@codeaurora.org>
Subject: Re: Query regarding ADMA descriptor allocation
Date: Sun, 13 Jan 2013 17:50:31 +0530
Message-ID: <50F2A68F.4000206@codeaurora.org>
References: <50F0061F.6070509@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from wolverine02.qualcomm.com ([199.106.114.251]:42481 "EHLO
	wolverine02.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754651Ab3AMMUi (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sun, 13 Jan 2013 07:20:38 -0500
In-Reply-To: <50F0061F.6070509@codeaurora.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: drzeus@drzeus.cx, linux-mmc@vger.kernel.org

Hi
Can you please let me know if my understanding in the below question is 
correct ?

Thanks
Asutosh

On 1/11/2013 6:01 PM, Asutosh Das wrote:
> Hi
> In sdhci_add_host function, the number of adma descriptors allocated 
> are 128 and each descriptor consumes 8 bytes and 1 4byte is added in 
> the end like,
> kmalloc((128 * 2 + 1) * 4, GFP_KERNEL);
>
> In sdhci_adma_table_pre function, each node in sg-list is iterated and 
> in case of a misaligned node, a descriptor is consumed, which means 
> for a single sg-node 2 descriptors were consumed. Let's say in a 
> situation, where there are multiple unaligned addresses in multiple sg 
> nodes and the sg-list length is 128, wouldn't this use up all the 128 
> descriptors long before the entire sg-list is traversed ?
>
>
>
>


-- 
Sent by a consultant of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.

