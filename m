From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH RESEND v6] mmc: core: Remove bounce buffer in mmc_send_cxd_data()
Date: Mon, 17 Sep 2012 03:32:12 -0400
Message-ID: <m3txuxyuir.fsf@pullcord.laptop.org>
References: <1343955483-6917-1-git-send-email-kyungsik.lee@lge.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1343955483-6917-1-git-send-email-kyungsik.lee@lge.com> (Kyungsik
	Lee's message of "Fri, 3 Aug 2012 09:58:03 +0900")
Sender: linux-kernel-owner@vger.kernel.org
To: Kyungsik Lee <kyungsik.lee@lge.com>
Cc: Venkatraman S <svenkatr@ti.com>, Jaehoon Chung <jh80.chung@samsung.com>, Adrian Hunter <ext-adrian.hunter@nokia.com>, Philip Rakity <prakity@marvell.com>, raphael.andy.lee@gmail.com, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

Hi,

On Thu, Aug 02 2012, Kyungsik Lee wrote:
> It is expected that Extended CSD register(the size of this register
> is larger than CID/CSD) will be referenced more frequently as more
> fields have been added to Extended CSD and it seems that it is not
> a good option to double the memory used.
>
> This patch is intended to avoid the use of bounce buffer for reading
> Extended CSD register in mmc_send_cxd_data(). It will provide a better
> performance gain by removing memcpy() overhead for a half KiB and
> a redundant bounce buffer allocated repeatedly at the cost of providing
> DMA-capable buffer from upper caller(but on-stack buffer is allowed
> with no performance gain).
>
> Signed-off-by: Kyungsik Lee <kyungsik.lee@lge.com>
> Reviewed-by: Venkatraman S <svenkatr@ti.com>

Thanks, pushed to mmc-next for 3.7.

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
