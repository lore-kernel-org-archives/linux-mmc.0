From: Randy Dunlap <rdunlap@infradead.org>
Subject: Re: [PATCH] mmc: mxcmmc: Fix missing parentheses and brace
Date: Fri, 13 Jul 2018 21:16:57 -0700
Message-ID: <4bba8958-b328-68c1-6eec-61ffe0f2f086@infradead.org>
References: <20180712195937.GA36007@beast>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180712195937.GA36007@beast>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Kees Cook <keescook@chromium.org>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: Christoph Hellwig <hch@lst.de>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

On 07/12/2018 12:59 PM, Kees Cook wrote:
> Looks like the adjusted syntax wasn't fully build tested. This fixes
> failures with powerpc builds:
> 
> drivers/mmc/host/mxcmmc.c: In function ‘mxcmci_swap_buffers’:
> drivers/mmc/host/mxcmmc.c:296:51: error: expected ‘)’ before ‘;’ token
>    void *buf = kmap_atomic(sg_page(sg) + sg->offset;
>                                                    ^
> drivers/mmc/host/mxcmmc.c:299:1: error: expected ‘,’ or ‘;’ before ‘}’ token
>  }
>  ^
> 
> Fixes: b189e7589f6d3 ("mmc: mxcmmc: handle highmem pages")
> Signed-off-by: Kees Cook <keescook@chromium.org>

Acked-by: Randy Dunlap <rdunlap@infradead.org>
Tested-by: Randy Dunlap <rdunlap@infradead.org>

Thanks.

> ---
>  drivers/mmc/host/mxcmmc.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/mmc/host/mxcmmc.c b/drivers/mmc/host/mxcmmc.c
> index 75f781c11e89..de4e6e5bf304 100644
> --- a/drivers/mmc/host/mxcmmc.c
> +++ b/drivers/mmc/host/mxcmmc.c
> @@ -293,9 +293,10 @@ static void mxcmci_swap_buffers(struct mmc_data *data)
>  	int i;
>  
>  	for_each_sg(data->sg, sg, data->sg_len, i) {
> -		void *buf = kmap_atomic(sg_page(sg) + sg->offset;
> +		void *buf = kmap_atomic(sg_page(sg) + sg->offset);
>  		buffer_swap32(buf, sg->length);
>  		kunmap_atomic(buf);
> +	}
>  }
>  #else
>  static inline void mxcmci_swap_buffers(struct mmc_data *data) {}
> 


-- 
~Randy
