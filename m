Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8C96C54EBD
	for <linux-mmc@archiver.kernel.org>; Fri, 13 Jan 2023 17:46:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230003AbjAMRq2 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 13 Jan 2023 12:46:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229652AbjAMRqB (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 13 Jan 2023 12:46:01 -0500
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com [IPv6:2607:f8b0:4864:20::82e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4561A94200
        for <linux-mmc@vger.kernel.org>; Fri, 13 Jan 2023 09:34:39 -0800 (PST)
Received: by mail-qt1-x82e.google.com with SMTP id y7so1112184qtv.5
        for <linux-mmc@vger.kernel.org>; Fri, 13 Jan 2023 09:34:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=in-reply-to:from:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=mcl6b5Wp/C+uwQcnUNhhyCs+cK4J9mcC+WHTCiuIgsg=;
        b=GS5lLqAFV/5tWiu6LJuxAzaOX4ZjoU9GjO3khh9gIDQlJYV0NJApr/1X1isVCQzo5I
         ofYOVnrs773zuOoNBn4OJ5CETDTDHQDxxJlK6sNq/Ec0z44pl8ZieUstLw3NRQXXXcd2
         5bJWaERd+ZPhvn+Yo3+KDhDikgv4jacMeNdn8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:from:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mcl6b5Wp/C+uwQcnUNhhyCs+cK4J9mcC+WHTCiuIgsg=;
        b=GC4/P+NNML2qr72qe8q7q/RXeTpU7TlrGGcHGTy6tdGJdwMuOxyxmJm4mt5FBJh6NB
         HaN/P2J7Lc9GTUPF8+T0ASHXZ2N+/BCm2fEjHrFDarF0+srQjepfxQiJiZLxQw7qLuun
         DGdmkoTLdDadrJO8P9lHJSsZSky7y7TgaVsHjWeIoQAVMoyDD2A/F6E6FNdypK6iBuCg
         HbgfFiO2nKwDktWFsLTJcRgP5uiq/ouuO5XftTeEn0jG0Wn3nFRAzYlDb6JwAoFcIcyA
         scZ80fAH2f1bl2AeC2JEQjWQBKd++sAy95DxFfdV5rObVLibv+AWsYKPrCjWXnucoSed
         i5/Q==
X-Gm-Message-State: AFqh2krYspG/y3Mgac6/frM6rHJ9lqsaaJvVHIN5XXOhW5dw+YSQTD/E
        6XQFn27N3A4oL91076Nr9mgxVQ==
X-Google-Smtp-Source: AMrXdXscXKgScy7nM/XDZt/FTiwZH4qGBvLkyg6+wQEa0eZuxFEdw8pRvAuFakxkkrCLc9G7asCYog==
X-Received: by 2002:a05:622a:1b1e:b0:3a7:ef7b:6aac with SMTP id bb30-20020a05622a1b1e00b003a7ef7b6aacmr106593792qtb.11.1673631278307;
        Fri, 13 Jan 2023 09:34:38 -0800 (PST)
Received: from [10.136.13.65] ([192.19.161.248])
        by smtp.gmail.com with ESMTPSA id t34-20020a05622a182200b003a527d29a41sm10824021qtc.75.2023.01.13.09.34.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Jan 2023 09:34:37 -0800 (PST)
Message-ID: <2646aa34-fde4-74c9-5ff4-be9a52f31b07@broadcom.com>
Date:   Fri, 13 Jan 2023 09:34:34 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH 5/6] mmc: sdhci-iproc: Replace SDHCI_QUIRK_MISSING_CAPS
To:     Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Kamal Dasu <kdasu.kdev@gmail.com>, Al Cooper <alcooperx@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        Jisheng Zhang <jszhang@kernel.org>,
        Marek Vasut <marex@denx.de>, linux-mmc@vger.kernel.org
References: <20230113110011.129835-1-adrian.hunter@intel.com>
 <20230113110011.129835-6-adrian.hunter@intel.com>
From:   Scott Branden <scott.branden@broadcom.com>
In-Reply-To: <20230113110011.129835-6-adrian.hunter@intel.com>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
        boundary="000000000000d9125905f228a5b4"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

--000000000000d9125905f228a5b4
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2023-01-13 03:00, Adrian Hunter wrote:
> SDHCI_QUIRK_MISSING_CAPS is not needed because __sdhci_read_caps() can be
> called instead.
> 
> In preparation to get rid of SDHCI_QUIRK_MISSING_CAPS, replace
> SDHCI_QUIRK_MISSING_CAPS with __sdhci_read_caps().
> 
> __sdhci_read_caps() is also called from sdhci_setup_host() via
> sdhci_read_caps(), however only the first call to __sdhci_read_caps() does
> anything because after that host->read_caps has been set to true.
> 
> Note, __sdhci_read_caps() does more than just set host->caps, such as do a
> reset, so calling __sdhci_read_caps() earlier could have unforeseen
> side-effects. However the code flow has been reviewed with that in mind.
> 
> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Acked-by: Scott Branden <scott.branden@broadcom.com>
> ---
>   drivers/mmc/host/sdhci-iproc.c | 14 ++++++++------
>   1 file changed, 8 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/mmc/host/sdhci-iproc.c b/drivers/mmc/host/sdhci-iproc.c
> index 6db35b1b8557..86eb0045515e 100644
> --- a/drivers/mmc/host/sdhci-iproc.c
> +++ b/drivers/mmc/host/sdhci-iproc.c
> @@ -18,6 +18,7 @@ struct sdhci_iproc_data {
>   	u32 caps;
>   	u32 caps1;
>   	u32 mmc_caps;
> +	bool missing_caps;
>   };
>   
>   struct sdhci_iproc_host {
> @@ -251,7 +252,6 @@ static const struct sdhci_iproc_data iproc_data = {
>   static const struct sdhci_pltfm_data sdhci_bcm2835_pltfm_data = {
>   	.quirks = SDHCI_QUIRK_BROKEN_CARD_DETECTION |
>   		  SDHCI_QUIRK_DATA_TIMEOUT_USES_SDCLK |
> -		  SDHCI_QUIRK_MISSING_CAPS |
>   		  SDHCI_QUIRK_NO_HISPD_BIT,
>   	.quirks2 = SDHCI_QUIRK2_PRESET_VALUE_BROKEN,
>   	.ops = &sdhci_iproc_32only_ops,
> @@ -266,6 +266,7 @@ static const struct sdhci_iproc_data bcm2835_data = {
>   	.caps1 = SDHCI_DRIVER_TYPE_A |
>   		 SDHCI_DRIVER_TYPE_C,
>   	.mmc_caps = 0x00000000,
> +	.missing_caps = true,
>   };
>   
>   static const struct sdhci_ops sdhci_iproc_bcm2711_ops = {
> @@ -295,8 +296,7 @@ static const struct sdhci_iproc_data bcm2711_data = {
>   };
>   
>   static const struct sdhci_pltfm_data sdhci_bcm7211a0_pltfm_data = {
> -	.quirks = SDHCI_QUIRK_MISSING_CAPS |
> -		SDHCI_QUIRK_BROKEN_TIMEOUT_VAL |
> +	.quirks = SDHCI_QUIRK_BROKEN_TIMEOUT_VAL |
>   		SDHCI_QUIRK_BROKEN_DMA |
>   		SDHCI_QUIRK_BROKEN_ADMA,
>   	.ops = &sdhci_iproc_ops,
> @@ -315,6 +315,7 @@ static const struct sdhci_iproc_data bcm7211a0_data = {
>   		SDHCI_CAN_DO_HISPD,
>   	.caps1 = SDHCI_DRIVER_TYPE_C |
>   		 SDHCI_DRIVER_TYPE_D,
> +	.missing_caps = true,
>   };
>   
>   static const struct of_device_id sdhci_iproc_of_match[] = {
> @@ -397,9 +398,10 @@ static int sdhci_iproc_probe(struct platform_device *pdev)
>   		}
>   	}
>   
> -	if (iproc_host->data->pdata->quirks & SDHCI_QUIRK_MISSING_CAPS) {
> -		host->caps = iproc_host->data->caps;
> -		host->caps1 = iproc_host->data->caps1;
> +	if (iproc_host->data->missing_caps) {
> +		__sdhci_read_caps(host, NULL,
> +				  &iproc_host->data->caps,
> +				  &iproc_host->data->caps1);
>   	}
>   
>   	ret = sdhci_add_host(host);

--000000000000d9125905f228a5b4
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

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
aon9PduLGVgSMfiFb2nQ2w0PzDSefbrZKRQAGcSvcQlWb8XU7YKGbLhjR9c/r3KF4iUW8w2T2pd+
bO6aQXt8b1C9YG/V+B65TuJXxgX0veIJEyP+Cl0Im5vNwwIDAQABo4IB2zCCAdcwDgYDVR0PAQH/
BAQDAgWgMIGjBggrBgEFBQcBAQSBljCBkzBOBggrBgEFBQcwAoZCaHR0cDovL3NlY3VyZS5nbG9i
YWxzaWduLmNvbS9jYWNlcnQvZ3NnY2NyM3BlcnNvbmFsc2lnbjJjYTIwMjAuY3J0MEEGCCsGAQUF
BzABhjVodHRwOi8vb2NzcC5nbG9iYWxzaWduLmNvbS9nc2djY3IzcGVyc29uYWxzaWduMmNhMjAy
MDBNBgNVHSAERjBEMEIGCisGAQQBoDIBKAowNDAyBggrBgEFBQcCARYmaHR0cHM6Ly93d3cuZ2xv
YmFsc2lnbi5jb20vcmVwb3NpdG9yeS8wCQYDVR0TBAIwADBJBgNVHR8EQjBAMD6gPKA6hjhodHRw
Oi8vY3JsLmdsb2JhbHNpZ24uY29tL2dzZ2NjcjNwZXJzb25hbHNpZ24yY2EyMDIwLmNybDAlBgNV
HREEHjAcgRpzY290dC5icmFuZGVuQGJyb2FkY29tLmNvbTATBgNVHSUEDDAKBggrBgEFBQcDBDAf
BgNVHSMEGDAWgBSWM9HmWBdbNHWKgVZk1b5I3qGPzzAdBgNVHQ4EFgQU8+MSO/sprODwb9D5cjaq
JNiLqgkwDQYJKoZIhvcNAQELBQADggEBAA25uPHwC95BhvFXuEOAk+J5FZV4v82uly/X7LATDzrf
tsww461GRAidKV8lvziiIw6OQQgO9Ei/yC8bVdzDLQJF2PhxcWhc+4II6AkUyRC+Tmfk7xmPEYSv
MHgQfpwPU6C1o4FI/8XjfJgk1dE4j4v16iLKC2qfBqfdzdT/cJaCg/fZfL0w5RLtGOOVIMBWwObx
UKmtYSCgcvRKmLailjlxgiUaYgxdZSpwR0RvFJapt0KzMR5OIP96iyXYVWbl9qy8uY9gqEeNaaQm
Bt8T4oEXHxRvse+Ij162RjEysEsDgkiE/koCb3YFlkVu5lL1N0M7EIo+XiuWWUEjuhztPasxggJt
MIICaQIBATBrMFsxCzAJBgNVBAYTAkJFMRkwFwYDVQQKExBHbG9iYWxTaWduIG52LXNhMTEwLwYD
VQQDEyhHbG9iYWxTaWduIEdDQyBSMyBQZXJzb25hbFNpZ24gMiBDQSAyMDIwAgxPA+M+AQMMGpZn
bCswDQYJYIZIAWUDBAIBBQCggdQwLwYJKoZIhvcNAQkEMSIEIMUOEGWgKiGPidcMsafet4Ilk9nS
ePrbpQs9gN93j6CXMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTIz
MDExMzE3MzQzOFowaQYJKoZIhvcNAQkPMVwwWjALBglghkgBZQMEASowCwYJYIZIAWUDBAEWMAsG
CWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQowCwYJKoZIhvcNAQEHMAsGCWCGSAFl
AwQCATANBgkqhkiG9w0BAQEFAASCAQCIlm9culaKhY4ivfVbO+qLjeDOsRAO1MoV5eXaJ+FsuNiC
8RLreOGTggH/juc+TK8GmIwNEq4iY8J+cnSDbgMg3DACbEOZfwV5u9HIJXBa4Ol74ANwLWXIinFt
SdhCKglMIfnpple4QetYGIKDJwbCP2zRQOLks4JcdmgL6gQn7XYE99IfWs4uo41hpwXUXZH19sZW
6bhYkkEIz4Oc8UxEyikJgmiUMwR+zbJsRtIh4kjLi5fK58lpiDI7UI2G9Ygfnp9w31kIYOhXzlVO
vo/BnG3QnviY0j4OD+k8pPzBW9GGT8/zqhI4dgvHYnkxq8pQaGmCsOVUFSwnZsv26RSI
--000000000000d9125905f228a5b4--
