From: Seungwon Jeon <tgih.jun@samsung.com>
Subject: RE: [PATCH v2 1/2] mmc: dw_mmc: Check return value of regulator_enable
Date: Thu, 04 Apr 2013 15:11:12 +0900
Message-ID: <004701ce30fb$353ce1b0$9fb6a510$%jun@samsung.com>
References: <1365054911-19928-1-git-send-email-sachin.kamat@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout1.samsung.com ([203.254.224.24]:42952 "EHLO
	mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756429Ab3DDGLP convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 4 Apr 2013 02:11:15 -0400
Received: from epcpsbgr4.samsung.com
 (u144.gpu120.samsung.co.kr [203.254.230.144])
 by mailout1.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTP id <0MKP00MT4VTLY1A0@mailout1.samsung.com> for
 linux-mmc@vger.kernel.org; Thu, 04 Apr 2013 15:11:13 +0900 (KST)
In-reply-to: <1365054911-19928-1-git-send-email-sachin.kamat@linaro.org>
Content-language: ko
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: 'Sachin Kamat' <sachin.kamat@linaro.org>, linux-mmc@vger.kernel.org
Cc: cjb@laptop.org, patches@linaro.org

On Thursday, April 04, 2013, Sachin Kamat wrote:
> regulator_enable() is declared with __must_check attribute.
> Hence check the return value to ensure that the regulator is enabled.
> Fixes the following warning:
> drivers/mmc/host/dw_mmc.c:2461:19: warning:
> ignoring return value of =E2=80=98regulator_enable=E2=80=99, declared=
 with attribute
> warn_unused_result [-Wunused-result]
> drivers/mmc/host/dw_mmc.c: In function =E2=80=98dw_mci_init_slot=E2=80=
=99:
> drivers/mmc/host/dw_mmc.c:1994:19: warning:
> ignoring return value of =E2=80=98regulator_enable=E2=80=99, declared=
 with attribute
> warn_unused_result [-Wunused-result]
>=20
> Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
> Acked-by: Jaehoon Chung <jh80.chung@samsung.com>
Acked-by: Seungwon Jeon <tgih.jun@samsung.com>

Thanks,
Seungwon Jeon

