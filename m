From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH RESEND] mmc: core: Assemble the codes of related to eMMC4.5
Date: Tue, 25 Oct 2011 06:39:11 -0400
Message-ID: <m2sjmh73u8.fsf@bob.laptop.org>
References: <002401cc92af$13358b30$39a0a190$%jun@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <002401cc92af$13358b30$39a0a190$%jun@samsung.com> (Seungwon
	Jeon's message of "Tue, 25 Oct 2011 09:43:12 +0900")
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Seungwon Jeon <tgih.jun@samsung.com>
Cc: linux-mmc@vger.kernel.org, linux-samsung-soc@vger.kernel.org, kgene.kim@samsung.com, dh.han@samsung.com
List-Id: linux-mmc@vger.kernel.org

Hi,

On Mon, Oct 24 2011, Seungwon Jeon wrote:
> Code cleanup. The codes of related to eMMC4.5 are scattered.
> This patch removes one if-statement and assembles all. And it also
> removes variable initialization below else-statement. It is obvious
> for previous version but seems unnecessary. All members of card structure
> are already set to zero at card-init.
>
> Signed-off-by: Seungwon Jeon <tgih.jun@samsung.com>

Thanks, pushed to mmc-next for 3.2.

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
