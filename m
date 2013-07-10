From: Seungwon Jeon <tgih.jun@samsung.com>
Subject: RE: [PATCH] mmc: dw_mmc: Handle DW_MCI_QUIRK_IDMAC_DTO properly
Date: Wed, 10 Jul 2013 23:54:36 +0900
Message-ID: <002901ce7d7d$65223e10$2f66ba30$%jun@samsung.com>
References: <1373400280-7408-1-git-send-email-dianders@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout3.samsung.com ([203.254.224.33]:56561 "EHLO
	mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752571Ab3GJOyi (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 10 Jul 2013 10:54:38 -0400
In-reply-to: <1373400280-7408-1-git-send-email-dianders@chromium.org>
Content-language: ko
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: 'Doug Anderson' <dianders@chromium.org>, 'Chris Ball' <cjb@laptop.org>
Cc: 'Markos Chandras' <markos.chandras@imgtec.com>, 'Jaehoon Chung' <jh80.chung@samsung.com>, 'James Hogan' <james.hogan@imgtec.com>, 'Grant Grundler' <grundler@chromium.org>, 'Alim Akhtar' <alim.akhtar@samsung.com>, 'Abhilash Kesavan' <a.kesavan@samsung.com>, 'Tomasz Figa' <tomasz.figa@gmail.com>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org

On Wed, July 10, 2013, Doug Anderson wrote:
> In (1fb5f68 mmc: dw_mmc: Don't loop when handling an interrupt), the
> code for handling DW_MCI_QUIRK_IDMAC_DTO became dead code.  Move it to
> where it ought to live.
> 
> Found by code inspection and compile-tested only--I don't know of any
> boards that need DW_MCI_QUIRK_IDMAC_DTO.
> 
> Signed-off-by: Doug Anderson <dianders@chromium.org>

Acked-by: Seungwon Jeon <tgih.jun@samsung.com>

