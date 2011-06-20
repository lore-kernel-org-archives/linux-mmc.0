From: Will Newton <will.newton@gmail.com>
Subject: Re: [PATCH] mmc: dw_mmc: protect a sequence of request and request-done.
Date: Mon, 20 Jun 2011 10:15:03 +0100
Message-ID: <BANLkTin1p20oOAft+cfKYcxUVE6Fh065UA@mail.gmail.com>
References: <1308558256-20824-1-git-send-email-tgih.jun@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <1308558256-20824-1-git-send-email-tgih.jun@samsung.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Seungwon Jeon <tgih.jun@samsung.com>
Cc: linux-samsung-soc@vger.kernel.org, linux-mmc@vger.kernel.org, akpm@linux-foundation.org, cjb@laptop.org, kgene.kim@samsung.com
List-Id: linux-mmc@vger.kernel.org

On Mon, Jun 20, 2011 at 9:24 AM, Seungwon Jeon <tgih.jun@samsung.com> wrote:
> Response timeout(RTO), Response crc error(RCRC) and Response error(RE)
> signals come with command done(CD) and can be raised preceding command
> done(CD). That is these error interrupts and CD can be handled in
> separate dw_mci_interrupt(). If mmc_request_done() is called because of
> response timeout before command done is occured, next request can be
> sent, but CD of current request is not finished. This can bring about
> a broken sequence of request and request-done.
>
> And Data error interrupt(DRTO, DCRC, SBE, EBE) and data transfer
> over(DTO) are same reanson.
>
> Signed-off-by: Seungwon Jeon <tgih.jun@samsung.com>

Acked-by: Will Newton <will.newton@imgtec.com>
