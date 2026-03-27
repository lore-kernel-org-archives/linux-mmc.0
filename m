Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D04A036AB46
	for <linux-mmc@vger.kernel.org>; Fri, 27 Mar 2026 09:36:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774604210; cv=pass; b=PONuuhiC8Z4mKj1ybQbQQYgn70Oqy7CXVSVK9zr5weahpZUNdX3HZOFV5GXGt/EwrxaWXbHQGHAM7CnDqYsYPsaSCtv3/TlRGQ1yMf50t9i2/b21zfYJhrefdgIuVnC/t38dPMMu8+U88fwrzGlPB3e4GjWXvlWP2dMlsw2MtKM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774604210; c=relaxed/simple;
	bh=Ke/OXFwuARyPCCa6DSz76nELinx4xlFUrxOXTYo46As=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WcvaRtJ5ULBQmFWI1P+JShOCFXvlgFyguY0zDdS40EbjuBK/kUwnL/T4zwzfJQey6R2xbQ0QYrNXudjxQ19vL4zlOW5hLTToP+JJ5SCatCa5/VBHCrwaZwB1ITnX5VtLIQuDJEjU8kt9/QZV8d1aVEM35q8C/UFi99u8d33W0JQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=MRchHse6; arc=pass smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="MRchHse6"
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-5a12cd0bcd8so413051e87.3
        for <linux-mmc@vger.kernel.org>; Fri, 27 Mar 2026 02:36:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774604207; cv=none;
        d=google.com; s=arc-20240605;
        b=Vg+3IqVeGrWZRsa5vRKESyer+w7T5ILvx7BP8i8DBhie200ywVvL7tb0CsdvUN3/m1
         ij3UOw8PZ103o1txW0hJzoMMbILZJ+TWQNUHv955r0IFsEKxY8bGC0Mo6+2DFWl4DTVf
         HPg6q0Uxl2Sg7B+D4RDNU7aoEKUsClshvXlvuEYTcEWYV4oUhKqmyIHQYy2hqB5SNsfZ
         s8XjwyFBbrfXSHThDIMX881cMiMAWRYGIQVwlovOiUfiGvKrrpPLyiarau2QthqESBEw
         DN6Jb7IUGYj25C4fBMXErLrrOF9Xy7D5dHH9I0DrB6fdO5pBvsE8w1+irFSuvmdLwr3l
         caNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=vQ3mg9eu23z1aT+oHgo+d+ZbECCe93Eys36nWJxEE5Y=;
        fh=ZAt5dYEk0RvEVVNjyNgwiCnyB3I3XO8SBztRftYnIYE=;
        b=HDz9dHYv2q6hkgxwy130WtpbOy/H1JRIPcnfXt3R1pHCQHebAdAyRuA8o+uRy1kQTE
         iIpLiqmB1NWlelOaTziAPBBJ4XFYDJf/MCdrbjlKVQqgDyDYgT9QdMu90/ipJrz61js4
         wFC9kR0KHYC9/RG+iUZTI9FOgFrLkEHr8qj9MonplwCrhhGnQyy4rXvjuo8Y1+AOgvPW
         pM2kNdLrTQWkNbBZs4OX5+kmq2LDXlndAYk7/1Eu632LupONeiUxY3Tgo9OTM2dbyqxl
         Xg0jUwCBWBFVXGrlWbg53zV/7nPay920sCIim9PCHvcnyLhYg7hcTd5qNyjxBHZvtCtj
         vluQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1774604207; x=1775209007; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=vQ3mg9eu23z1aT+oHgo+d+ZbECCe93Eys36nWJxEE5Y=;
        b=MRchHse6t8enn0+9qPpBgQCeZg1xtEhgCF8Gb3ll3ymkWi4DsRlPP2JkRJQWEWggSq
         vPIgxsJ8AOyG6VuhpCsl+jqWrDgdBxhm7fmVtWmbYdViF8k/YLnGzXU9FCjjOYnvEI+V
         esyfLUfQm2F0oK5Yu4eEjftmUDtSi85h3VrAJYrs2EJF5kpoaGMg7KT5F6wxcvC1d35u
         XQFZL8Ym6NSc9Z7aqX7ycThueUOV6YAsQ9c0gbyIxeKeqKYOfTEoJtUg4GoX7u3f16PB
         vS19p10Zmqm+aukdOrf6+10P/SGBfV2/SDZoiSw8hnmknm+qRuMlOXvINa72AGFdV9cz
         2BRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774604207; x=1775209007;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vQ3mg9eu23z1aT+oHgo+d+ZbECCe93Eys36nWJxEE5Y=;
        b=KI4S9U0x6KEUAcOMHksBD4NbtmxahIJAcQACG71FZDhA49qhaonfdm4gcGdc7cAwzu
         /LUbhNEeCJq1v111JIQx75bMuaoTwil8VxzVCL59cy/jr3ALzE7WC9iWlNK5XqZKq4iy
         5gWo+akeYYbQWle+aVSCxvCvVExx14r474M0+XyQEIKthkjM7IgV4T9ye7fQqUMf3Pli
         AOHd/kPJJQf5VqjKN4Aotz8eRUkZWN1cFsCVUMUVe5FOs4X4PqklRIoGtGpBrtDUYMu1
         mceMlvUJ8fNCo8nNxQYZJjKl/I8fr9+D+WMwjd3vihEmpq32EDo3+Qqe9fMRg0VIcnPz
         AOxg==
X-Gm-Message-State: AOJu0Yw/DCspcCRzYJS+/1g1IvYnjF8B7HmgJyKeiR12GyN3C6kkrsdD
	oUX9c9M49yoEkICUMAD0S//Ti4XU9D3gX+jFeJuTQEECVS3y0WvPgVZL9xTOo6lvrkS3L0v7eky
	aKXlsaU4G/Me5b9U8w1LSQWRrsjY9mvjZAhg37xsKxA==
X-Gm-Gg: ATEYQzxmxo4v7vte7iOJ+obl/mQMQCHCcgVeFgVYKqH64lc/BZCJEPzLWe5e1ETJBUY
	XJLv/6MKJdyWGk2QoaGMii01yJ+p/mZ6zePDzQ+HRx3Ekj9QiSUM68xSHfr5hx7aQjIm8zX9K7K
	OfVz/EAA2cTvYZ9SxmR0cVmo37KwwRyzj1QxvHOOiI6/PKxHYokZsUmlIjuOcBPdB2YQD+c47A3
	ZcEXGgsicpno3woS+IPJoCV+qIw74LIaJIIqTjTYUaRVr3nqLHsrE4sWuChy150YG4RpGB8SpVr
	5U0vIJeU
X-Received: by 2002:a05:6512:33c3:b0:5a1:2a8:ced7 with SMTP id
 2adb3069b0e04-5a2ab92f464mr620473e87.36.1774604206860; Fri, 27 Mar 2026
 02:36:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260327025849.8085-1-rosenp@gmail.com>
In-Reply-To: <20260327025849.8085-1-rosenp@gmail.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Fri, 27 Mar 2026 10:36:10 +0100
X-Gm-Features: AQROBzAg20uCmE0k4Nr0ejPhImIl4mAHsa7ydC91HvIBv7u_kbncgPzg9lHjDjM
Message-ID: <CAPDyKFr1SdB_geQD_QmOSpHBfgY1SjMgyfgR_H07iqxN6=WBJA@mail.gmail.com>
Subject: Re: [PATCH] mmc: mmc_test: use kzalloc_flex
To: Rosen Penev <rosenp@gmail.com>
Cc: linux-mmc@vger.kernel.org, Kees Cook <kees@kernel.org>, 
	"Gustavo A. R. Silva" <gustavoars@kernel.org>, open list <linux-kernel@vger.kernel.org>, 
	"open list:KERNEL HARDENING (not covered by other areas):Keyword:b__counted_by(_le|_be)?b" <linux-hardening@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Fri, 27 Mar 2026 at 03:59, Rosen Penev <rosenp@gmail.com> wrote:
>
> Simplifies allocations by using a flexible array member in these structs.
>
> Add __counted_by to get extra runtime analysis.
>
> Signed-off-by: Rosen Penev <rosenp@gmail.com>

Nice!

Applied for next, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/core/mmc_test.c | 28 ++++++++++------------------
>  1 file changed, 10 insertions(+), 18 deletions(-)
>
> diff --git a/drivers/mmc/core/mmc_test.c b/drivers/mmc/core/mmc_test.c
> index 43fdb67d5407..f5c542855037 100644
> --- a/drivers/mmc/core/mmc_test.c
> +++ b/drivers/mmc/core/mmc_test.c
> @@ -51,12 +51,12 @@ struct mmc_test_pages {
>
>  /**
>   * struct mmc_test_mem - allocated memory.
> - * @arr: array of allocations
>   * @cnt: number of allocations
> + * @arr: array of allocations
>   */
>  struct mmc_test_mem {
> -       struct mmc_test_pages *arr;
>         unsigned int cnt;
> +       struct mmc_test_pages arr[] __counted_by(cnt);
>  };
>
>  /**
> @@ -135,21 +135,22 @@ struct mmc_test_dbgfs_file {
>   * struct mmc_test_card - test information.
>   * @card: card under test
>   * @scratch: transfer buffer
> - * @buffer: transfer buffer
>   * @highmem: buffer for highmem tests
>   * @area: information for performance tests
>   * @gr: pointer to results of current testcase
> + * @buffer: transfer buffer
>   */
>  struct mmc_test_card {
>         struct mmc_card *card;
>
>         u8              scratch[BUFFER_SIZE];
> -       u8              *buffer;
>  #ifdef CONFIG_HIGHMEM
>         struct page     *highmem;
>  #endif
>         struct mmc_test_area            area;
>         struct mmc_test_general_result  *gr;
> +
> +       u8              buffer[];
>  };
>
>  enum mmc_test_prep_media {
> @@ -315,7 +316,6 @@ static void mmc_test_free_mem(struct mmc_test_mem *mem)
>         while (mem->cnt--)
>                 __free_pages(mem->arr[mem->cnt].page,
>                              mem->arr[mem->cnt].order);
> -       kfree(mem->arr);
>         kfree(mem);
>  }
>
> @@ -348,14 +348,10 @@ static struct mmc_test_mem *mmc_test_alloc_mem(unsigned long min_sz,
>         if (max_segs > max_page_cnt)
>                 max_segs = max_page_cnt;
>
> -       mem = kzalloc_obj(*mem);
> +       mem = kzalloc_flex(*mem, arr, max_segs);
>         if (!mem)
>                 return NULL;
>
> -       mem->arr = kzalloc_objs(*mem->arr, max_segs);
> -       if (!mem->arr)
> -               goto out_free;
> -
>         while (max_page_cnt) {
>                 struct page *page;
>                 unsigned int order;
> @@ -3099,7 +3095,7 @@ static ssize_t mtf_test_write(struct file *file, const char __user *buf,
>         if (ret)
>                 return ret;
>
> -       test = kzalloc_obj(*test);
> +       test = kzalloc_flex(*test, buffer, BUFFER_SIZE);
>         if (!test)
>                 return -ENOMEM;
>
> @@ -3111,7 +3107,6 @@ static ssize_t mtf_test_write(struct file *file, const char __user *buf,
>
>         test->card = card;
>
> -       test->buffer = kzalloc(BUFFER_SIZE, GFP_KERNEL);
>  #ifdef CONFIG_HIGHMEM
>         test->highmem = alloc_pages(GFP_KERNEL | __GFP_HIGHMEM, BUFFER_ORDER);
>         if (!test->highmem) {
> @@ -3120,17 +3115,14 @@ static ssize_t mtf_test_write(struct file *file, const char __user *buf,
>         }
>  #endif
>
> -       if (test->buffer) {
> -               mutex_lock(&mmc_test_lock);
> -               mmc_test_run(test, testcase);
> -               mutex_unlock(&mmc_test_lock);
> -       }
> +       mutex_lock(&mmc_test_lock);
> +       mmc_test_run(test, testcase);
> +       mutex_unlock(&mmc_test_lock);
>
>  #ifdef CONFIG_HIGHMEM
>         __free_pages(test->highmem, BUFFER_ORDER);
>  free_test_buffer:
>  #endif
> -       kfree(test->buffer);
>         kfree(test);
>
>         return count;
> --
> 2.53.0
>
