Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B37B1C433C1
	for <linux-mmc@archiver.kernel.org>; Mon, 22 Mar 2021 19:12:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7167B619A2
	for <linux-mmc@archiver.kernel.org>; Mon, 22 Mar 2021 19:12:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231167AbhCVTLs (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 22 Mar 2021 15:11:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231782AbhCVTLe (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 22 Mar 2021 15:11:34 -0400
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8F84C061762
        for <linux-mmc@vger.kernel.org>; Mon, 22 Mar 2021 12:11:33 -0700 (PDT)
Received: by mail-pg1-x529.google.com with SMTP id h25so9293255pgm.3
        for <linux-mmc@vger.kernel.org>; Mon, 22 Mar 2021 12:11:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to;
        bh=9mOgSi4XDt8veEJ/AaUA6R1PR+tNshXPcnc1TiZlfns=;
        b=Uat4yS8OY5vuZtQBhCsjMBha1TputZoLiXCUY45xl5JN2toOR79Hz7SEJIKzzlayUf
         S/WhF9UV59INAdK7kINVUphe8zn3aDJZpHnavUd2a3U59JVH6IH6IaQVcDFvjJsMl+t+
         91kKBDTQk09nrqyZSEKJbKxZComgaYn9ckO48=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to;
        bh=9mOgSi4XDt8veEJ/AaUA6R1PR+tNshXPcnc1TiZlfns=;
        b=VmSNLq2ShhrM9nr3tVblMm0/umZAdI6D5adKj/JX+sU7D7ykRozQ/J2i5jUYpnMnQ1
         6uFtsx3Ju0C3VYt8Ea3eqCV3Q2WCoRjqf9BRDNTM0jL+WJ+LfVaNWoTtqWZLG03DPmzY
         9yNfAEEifJc5WJGgGK+rsy6YcIC51Ji7pLQN4jPKs7ElLHlz0AfwvehnTnI9Itzv0CtE
         KpxJvJMlj2/StVu/ORWjqo+cWCTQCvRGdFH+EHJa8ySO5tXAxBDKAAK9nl7b1JdKRMYg
         boSameAV+Q0gzWSuvIp7u6rnctrmmykLIQU91U5TOmFrHRVUJdb88F4RZj2FIp8eNlic
         pgww==
X-Gm-Message-State: AOAM533at8MFPPPHIOEcwsJTyPC+eDDJ4xJzU0tgaNdy+rBRoBi496lj
        D47dYz164tmJmoFJnp7tn+HawA==
X-Google-Smtp-Source: ABdhPJyNmFSj5zo/68O1/44yaGHaf2Hen3v/j9Fyi4nQm9MM+qVOfEt1gseSGe7p58iLf707jVXgeQ==
X-Received: by 2002:aa7:8dda:0:b029:1fa:19b3:7ed9 with SMTP id j26-20020aa78dda0000b02901fa19b37ed9mr979527pfr.32.1616440293076;
        Mon, 22 Mar 2021 12:11:33 -0700 (PDT)
Received: from lbrmn-lnxub113.ric.broadcom.net ([192.19.228.250])
        by smtp.gmail.com with ESMTPSA id y19sm15681558pfo.0.2021.03.22.12.11.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Mar 2021 12:11:32 -0700 (PDT)
Subject: Re: [PATCH 1/4] dt-bindings: mmc: iproc-sdhci: Convert to json-schema
To:     Nicolas Saenz Julienne <nsaenz@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-mmc@vger.kernel.org,
        devicetree@vger.kernel.org, bcm-kernel-feedback-list@broadcom.com,
        linux-rpi-kernel@lists.infradead.org,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>
Cc:     f.fainelli@gmail.com, phil@raspberrypi.com,
        tim.gover@raspberrypi.com, adrian.hunter@intel.com,
        alcooperx@gmail.com, nsaenzjulienne@suse.de,
        linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>
References: <20210322185816.27582-1-nsaenz@kernel.org>
 <20210322185816.27582-2-nsaenz@kernel.org>
From:   Scott Branden <scott.branden@broadcom.com>
Message-ID: <0e98588e-65f1-6839-1fcd-584b480a31bd@broadcom.com>
Date:   Mon, 22 Mar 2021 12:11:29 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210322185816.27582-2-nsaenz@kernel.org>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
        boundary="0000000000007e52a505be24d538"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

--0000000000007e52a505be24d538
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit

On 2021-03-22 11:58 a.m., Nicolas Saenz Julienne wrote:
> Convert the brcm,iproc-sdhci binding to DT schema format using json-schema
> 
> Signed-off-by: Nicolas Saenz Julienne <nsaenz@kernel.org>
> ---
>  .../bindings/mmc/brcm,iproc-sdhci.yaml        | 58 +++++++++++++++++++
>  .../bindings/mmc/brcm,sdhci-iproc.txt         | 37 ------------
>  2 files changed, 58 insertions(+), 37 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/mmc/brcm,iproc-sdhci.yaml
>  delete mode 100644 Documentation/devicetree/bindings/mmc/brcm,sdhci-iproc.txt
> 
> diff --git a/Documentation/devicetree/bindings/mmc/brcm,iproc-sdhci.yaml b/Documentation/devicetree/bindings/mmc/brcm,iproc-sdhci.yaml
> new file mode 100644
> index 000000000000..19d84f3ef9e6
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mmc/brcm,iproc-sdhci.yaml
> @@ -0,0 +1,58 @@
> +# SPDX-License-Identifier: GPL-2.0
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/mmc/brcm,iproc-sdhci.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Broadcom IPROC SDHCI controller
> +
> +maintainers:
> +  - Nicolas Saenz Julienne <nsaenz@kernel.org>
This is already covered in the MAINTAINERS section via "N:	iproc".
M:	Ray Jui <ray.jui@broadcom.com>

M:	Scott Branden <scott.branden@broadcom.com>

M:	bcm-kernel-feedback-list@broadcom.com
> +
> +allOf:
> +  - $ref: mmc-controller.yaml#
> +
> +properties:
> +  compatible:
> +    enum:
> +      - brcm,bcm2835-sdhci
> +      - brcm,bcm2711-emmc2
> +      - brcm,sdhci-iproc-cygnus
> +      - brcm,sdhci-iproc
> +
> +  reg:
> +    minItems: 1
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  clocks:
> +    maxItems: 1
> +    description:
> +      Handle to core clock for the sdhci controller.
> +
> +  sdhci,auto-cmd12:
> +    type: boolean
> +    description: Specifies that controller should use auto CMD12
> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupts
> +  - clocks
> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    sdhci0: sdhci@18041000 {
> +      compatible = "brcm,sdhci-iproc-cygnus";
> +      reg = <0x18041000 0x100>;
> +      interrupts = <GIC_SPI 108 IRQ_TYPE_LEVEL_HIGH>;
> +      clocks = <&lcpll0_clks BCM_CYGNUS_LCPLL0_SDIO_CLK>;
> +      bus-width = <4>;
> +      sdhci,auto-cmd12;
> +      no-1-8-v;
> +    };
> +
> +...
> diff --git a/Documentation/devicetree/bindings/mmc/brcm,sdhci-iproc.txt b/Documentation/devicetree/bindings/mmc/brcm,sdhci-iproc.txt
> deleted file mode 100644
> index 09d87cc1182a..000000000000
> --- a/Documentation/devicetree/bindings/mmc/brcm,sdhci-iproc.txt
> +++ /dev/null
> @@ -1,37 +0,0 @@
> -Broadcom IPROC SDHCI controller
> -
> -This file documents differences between the core properties described
> -by mmc.txt and the properties that represent the IPROC SDHCI controller.
> -
> -Required properties:
> -- compatible : Should be one of the following
> -	       "brcm,bcm2835-sdhci"
> -	       "brcm,bcm2711-emmc2"
> -	       "brcm,sdhci-iproc-cygnus"
> -	       "brcm,sdhci-iproc"
> -
> -Use brcm2835-sdhci for the eMMC controller on the BCM2835 (Raspberry Pi) and
> -bcm2711-emmc2 for the additional eMMC2 controller on BCM2711.
> -
> -Use sdhci-iproc-cygnus for Broadcom SDHCI Controllers
> -restricted to 32bit host accesses to SDHCI registers.
> -
> -Use sdhci-iproc for Broadcom SDHCI Controllers that allow standard
> -8, 16, 32-bit host access to SDHCI register.
> -
> -- clocks : The clock feeding the SDHCI controller.
> -
> -Optional properties:
> -  - sdhci,auto-cmd12: specifies that controller should use auto CMD12.
> -
> -Example:
> -
> -sdhci0: sdhci@18041000 {
> -	compatible = "brcm,sdhci-iproc-cygnus";
> -	reg = <0x18041000 0x100>;
> -	interrupts = <GIC_SPI 108 IRQ_TYPE_LEVEL_HIGH>;
> -	clocks = <&lcpll0_clks BCM_CYGNUS_LCPLL0_SDIO_CLK>;
> -	bus-width = <4>;
> -	sdhci,auto-cmd12;
> -	no-1-8-v;
> -};
> 


--0000000000007e52a505be24d538
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

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
cRe0CRXA7ypOJSgxO/nOOyQoaJxT7CGg1npOeSpPjEuc3fE4xum3l0nvU85hj6MlKZu43hokdBh0
D0nLyyhEwlR3AC/msdff/UGbM/JR9vk812RP4m/aNWZFJwIDAQABo4IB2zCCAdcwDgYDVR0PAQH/
BAQDAgWgMIGjBggrBgEFBQcBAQSBljCBkzBOBggrBgEFBQcwAoZCaHR0cDovL3NlY3VyZS5nbG9i
YWxzaWduLmNvbS9jYWNlcnQvZ3NnY2NyM3BlcnNvbmFsc2lnbjJjYTIwMjAuY3J0MEEGCCsGAQUF
BzABhjVodHRwOi8vb2NzcC5nbG9iYWxzaWduLmNvbS9nc2djY3IzcGVyc29uYWxzaWduMmNhMjAy
MDBNBgNVHSAERjBEMEIGCisGAQQBoDIBKAowNDAyBggrBgEFBQcCARYmaHR0cHM6Ly93d3cuZ2xv
YmFsc2lnbi5jb20vcmVwb3NpdG9yeS8wCQYDVR0TBAIwADBJBgNVHR8EQjBAMD6gPKA6hjhodHRw
Oi8vY3JsLmdsb2JhbHNpZ24uY29tL2dzZ2NjcjNwZXJzb25hbHNpZ24yY2EyMDIwLmNybDAlBgNV
HREEHjAcgRpzY290dC5icmFuZGVuQGJyb2FkY29tLmNvbTATBgNVHSUEDDAKBggrBgEFBQcDBDAf
BgNVHSMEGDAWgBSWM9HmWBdbNHWKgVZk1b5I3qGPzzAdBgNVHQ4EFgQUOhjEpl04Sz9dh5MI82E1
V39lM/owDQYJKoZIhvcNAQELBQADggEBAA7Rlypx/esz/iq1yA4+KW7uwV/aBY344BWcXt6I+SNK
VwFBgFWfLj5vaEud9TVv2fPSiaHJo0umemOJk+43QD+bsoqmgcFXd21PrOt7Jjs+jjVED9VC5kJq
S4NNKUkS+BqijJwSegtVygrc/atrIlJbjI21q4qpemUo5fgwqCNm++BmBGTI8yA09vtGSNDRN42k
lLX9hl3iEj5SBgkQqCbbnoE+ZjjKfqt7ED166WhgyQWNrl39yLcvLj+JRUB3RuvXKZjH0NQEEBII
wZBDSkyneykLt3CBNIhSCTxKM6OWxVp936ALSa5K9FNy00TeWSpokR6NmzaW8VD/EjTgvqAxggJt
MIICaQIBATBrMFsxCzAJBgNVBAYTAkJFMRkwFwYDVQQKExBHbG9iYWxTaWduIG52LXNhMTEwLwYD
VQQDEyhHbG9iYWxTaWduIEdDQyBSMyBQZXJzb25hbFNpZ24gMiBDQSAyMDIwAgx9oXSJpKniO4dS
Gk8wDQYJYIZIAWUDBAIBBQCggdQwLwYJKoZIhvcNAQkEMSIEIOWPHTI6WFm46vYwtXzDzhjEvRKB
QUCOxZBQZeEi+SZSMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTIx
MDMyMjE5MTEzM1owaQYJKoZIhvcNAQkPMVwwWjALBglghkgBZQMEASowCwYJYIZIAWUDBAEWMAsG
CWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQowCwYJKoZIhvcNAQEHMAsGCWCGSAFl
AwQCATANBgkqhkiG9w0BAQEFAASCAQAcBVN7TzFd+H/VaeODheWtIQRjRtsZWkHawVO6aG0qftcD
eKo95jY1oYmOSg90caJ3joWIIsKB26aWcHJiy+V37/6YG1W/Avg62CEzgOrxTOmgLgFRwjRKa9xr
Q3Jhv9bUg8McqpzeppVsWQ3Lunrb8CqbU6dyW8lgwTBRxkIzH3mEBqMETILbeIle8v0s6XGA0khG
AxcO4FdM4q2RDXOwowbxujX2rggnaYd7+Kp1sNwW+r6g6Wh7jwS/HMJObyH6HCKttTlikmFoVOi1
D//h9nq2N8O6lEVmpENqYyEGPfweFBOn3qo2V9MyssvmZqs8w1e/wblmmL+pUm/vf84q
--0000000000007e52a505be24d538--
