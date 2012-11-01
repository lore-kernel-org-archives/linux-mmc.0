From: Daniel Drake <dsd@laptop.org>
Subject: Re: sdhci vccq regulator support drops UHS-I flags
Date: Thu, 1 Nov 2012 11:29:34 -0600
Message-ID: <CAMLZHHRh41LwWmRm2YWGp2mWzvPmNKGZM2Pf6f3cwi2DPFE8bQ@mail.gmail.com>
References: <CAMLZHHS-xSEEFpKOEZyxG8CLQqwzwCYw8k=bbO3psEeZ78ZeNQ@mail.gmail.com>
	<E4ECCB94-95A7-4350-8FBD-1CB0D6D52ED6@nvidia.com>
	<CAMLZHHTDrzMc8J89dbyuvy6P_Qe0ynoQW7RFje9_8ppYNkFOSw@mail.gmail.com>
	<548D1E66-2AAF-4ACC-B08D-4F5B2719605F@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-da0-f46.google.com ([209.85.210.46]:48665 "EHLO
	mail-da0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1762065Ab2KAR3e (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 1 Nov 2012 13:29:34 -0400
Received: by mail-da0-f46.google.com with SMTP id n41so1258251dak.19
        for <linux-mmc@vger.kernel.org>; Thu, 01 Nov 2012 10:29:34 -0700 (PDT)
In-Reply-To: <548D1E66-2AAF-4ACC-B08D-4F5B2719605F@nvidia.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Philip Rakity <prakity@nvidia.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>

On Tue, Oct 30, 2012 at 3:07 PM, Philip Rakity <prakity@nvidia.com> wrote:
> The intent is if there is no regulator should hit this if statement.
>
> +       if (IS_ERR(host->vqmmc)) {
> +               pr_info("%s: no vqmmc regulator found\n", mmc_hostname(mmc));
> +               host->vqmmc = NULL;

There's a bug here then.
When there is no regulator, host->vqmmc is NULL.
NULL is not an error recognised by IS_ERR.

Double checked this with a simple test:

#include <stdio.h>

#define MAX_ERRNO       4095
#define IS_ERR_VALUE(x) ((x) >= (unsigned long)-MAX_ERRNO)

static inline long IS_ERR(const void *ptr)
{
return IS_ERR_VALUE((unsigned long)ptr);
}

int main(void)
{
if (IS_ERR(NULL))
printf("NULL is error\n");
else
printf("NULL is not error\n");
}



result: NULL is not error
