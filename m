From: santosh shilimkar <santosh.shilimkar@oracle.com>
Subject: Re: [PATCH 1/5] ARM: Keystone: Enable PINCTRL for Keystone ARCH
Date: Tue, 20 Oct 2015 18:26:20 -0700
Message-ID: <5626E9BC.40300@oracle.com>
References: <1445377809-12516-1-git-send-email-fcooper@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from aserp1040.oracle.com ([141.146.126.69]:36648 "EHLO
	aserp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751621AbbJUB0v (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 20 Oct 2015 21:26:51 -0400
In-Reply-To: <1445377809-12516-1-git-send-email-fcooper@ti.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Franklin S Cooper Jr <fcooper@ti.com>, linux@arm.linux.org.uk, ssantosh@kernel.org, ulf.hansson@linaro.org, m-karicheri2@ti.com, grygorii.strashko@ti.com, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org

On 10/20/2015 2:50 PM, Franklin S Cooper Jr wrote:
> From: Franklin Cooper <fcooper@ti.com>
>
> Unlike other Keystone 2 devices, newer Keystone 2 SOCs may utilize
> pinmuxing which requires PINCTRL to be enabled. Therefore, enable
> PINCTRL for all Keystone 2 devices.
>
> Signed-off-by: Franklin S Cooper Jr <fcooper@ti.com>
> ---
>   arch/arm/mach-keystone/Kconfig | 1 +
>   1 file changed, 1 insertion(+)
>
I would be happy to add this one when I see pin
control data in DTS and its actually going to be
used in upstream kernel. Till then I don't want
to add this one.

Regards,
Santosh
