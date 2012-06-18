From: Namjae Jeon <linkinjeon@gmail.com>
Subject: Re: [PATCH RESEND v7 2/3] mmc: core: Support packed write command for
 eMMC4.5 device
Date: Mon, 18 Jun 2012 23:11:56 +0900
Message-ID: <CAKYAXd82Y54=CQf2hRaXEZ_NrG9xE2-YTrsS9cFtFoCBv0u8YA@mail.gmail.com>
References: <007b01cd4d15$40673510$c1359f30$%jun@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <007b01cd4d15$40673510$c1359f30$%jun@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Seungwon Jeon <tgih.jun@samsung.com>
Cc: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, Chris Ball <cjb@laptop.org>, Maya Erez <merez@codeaurora.org>, Subhash Jadavani <subhashj@codeaurora.org>, "S, Venkatraman" <svenkatr@ti.com>
List-Id: linux-mmc@vger.kernel.org

2012/6/18 Seungwon Jeon <tgih.jun@samsung.com>:
> This patch supports packed write command of eMMC4.5 device.
> Several writes can be grouped in packed command and all data
> of the individual commands can be sent in a single transfer
> on the bus.
>
> Signed-off-by: Seungwon Jeon <tgih.jun@samsung.com>
> ---
this patch looks good to me also.
Reviewed-by: Namjae Jeon <linkinjeon@gmail.com>

Thanks.
