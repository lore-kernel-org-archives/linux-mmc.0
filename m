From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH v2 1/2] mmc: dw_mmc: Check return value of regulator_enable
Date: Thu, 04 Apr 2013 10:18:52 -0400
Message-ID: <87bo9upeer.fsf@octavius.laptop.org>
References: <1365054911-19928-1-git-send-email-sachin.kamat@linaro.org>
	<004701ce30fb$353ce1b0$9fb6a510$%jun@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:33086 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1761161Ab3DDOS5 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 4 Apr 2013 10:18:57 -0400
In-Reply-To: <004701ce30fb$353ce1b0$9fb6a510$%jun@samsung.com> (Seungwon
	Jeon's message of "Thu, 04 Apr 2013 15:11:12 +0900")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Seungwon Jeon <tgih.jun@samsung.com>
Cc: 'Sachin Kamat' <sachin.kamat@linaro.org>, linux-mmc@vger.kernel.org, patches@linaro.org

Hi,

On Thu, Apr 04 2013, Seungwon Jeon wrote:
> On Thursday, April 04, 2013, Sachin Kamat wrote:
>> regulator_enable() is declared with __must_check attribute.
>> Hence check the return value to ensure that the regulator is enabled=
=2E
>> Fixes the following warning:
>> drivers/mmc/host/dw_mmc.c:2461:19: warning:
>> ignoring return value of =E2=80=98regulator_enable=E2=80=99, declare=
d with attribute
>> warn_unused_result [-Wunused-result]
>> drivers/mmc/host/dw_mmc.c: In function =E2=80=98dw_mci_init_slot=E2=80=
=99:
>> drivers/mmc/host/dw_mmc.c:1994:19: warning:
>> ignoring return value of =E2=80=98regulator_enable=E2=80=99, declare=
d with attribute
>> warn_unused_result [-Wunused-result]
>>=20
>> Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
>> Acked-by: Jaehoon Chung <jh80.chung@samsung.com>
> Acked-by: Seungwon Jeon <tgih.jun@samsung.com>

Thanks, both patches pushed to mmc-next for 3.10.

- Chris.
--=20
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
