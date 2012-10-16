From: Seungwon Jeon <tgih.jun@samsung.com>
Subject: RE: [PATCH] dw_mmc: fix multiple drv_data NULL dereferences
Date: Tue, 16 Oct 2012 19:54:12 +0900
Message-ID: <001701cdab8c$93e1eac0$bba5c040$%jun@samsung.com>
References: <1350376988-27477-1-git-send-email-james.hogan@imgtec.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ks_c_5601-1987
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout3.samsung.com ([203.254.224.33]:58159 "EHLO
	mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753397Ab2JPKyV (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 16 Oct 2012 06:54:21 -0400
In-reply-to: <1350376988-27477-1-git-send-email-james.hogan@imgtec.com>
Content-language: ko
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: 'James Hogan' <james.hogan@imgtec.com>, 'Chris Ball' <cjb@laptop.org>, 'Will Newton' <will.newton@imgtec.com>, 'Thomas Abraham' <thomas.abraham@linaro.org>
Cc: 'Jaehoon Chung' <jh80.chung@samsung.com>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org

On Tuesday, October 16, James Hogan <james.hogan@imgtec.com>
> Commit 800d78bfccb3d38116abfda2a5b9c8afdbd5ea21 ("mmc: dw_mmc: add
> support for implementation specific callbacks") merged in v3.7-rc1.
> 
> The above commit introduced multiple NULL pointer dereferences when
> the default dw_mci_pltfm_probe() is used, as it sets host->drv_data to
> NULL, and that's only checked against NULL in 1 out of the 7 cases where
> it is dereferenced.
> 
> Signed-off-by: James Hogan <james.hogan@imgtec.com>

Acked-by: Seungwon Jeon <tgih.jun@samsung.com>

Looks good to me.
Thanks.

Seungwon Jeon

