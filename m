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
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1F5AC433DB
	for <linux-mmc@archiver.kernel.org>; Wed, 24 Mar 2021 16:44:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6865C61A0E
	for <linux-mmc@archiver.kernel.org>; Wed, 24 Mar 2021 16:44:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236462AbhCXQnv (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 24 Mar 2021 12:43:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235878AbhCXQnu (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 24 Mar 2021 12:43:50 -0400
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41D61C0613DE
        for <linux-mmc@vger.kernel.org>; Wed, 24 Mar 2021 09:43:50 -0700 (PDT)
Received: by mail-pg1-x52d.google.com with SMTP id v186so14993230pgv.7
        for <linux-mmc@vger.kernel.org>; Wed, 24 Mar 2021 09:43:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to;
        bh=Og+eaH+C21j3XxDw4GXv3pRXoz9LnSyCv3cCFzbgmms=;
        b=hUER4Il0T2kikT8+/b4jYt0kMWtcyCwkxmHhyof2ZQro3Cpt1JxzIM/WctboyoU1t0
         IsNX6DC5++fXQdzmZqdJK5hspWLPjrsYSmSFaZKAzB5bgqJMvoi9pZ/GeS5UACo0Jfsm
         WqHnSV54Y1x0QM6K/fURQV5IfcMaM8QzpEzkM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to;
        bh=Og+eaH+C21j3XxDw4GXv3pRXoz9LnSyCv3cCFzbgmms=;
        b=q4eJdCVP9jNbv31fynSBPZxfAKvTCkMoh/eUKT2yfWsa3zkSGX8VpkXyHf6MuHJOGO
         0q9zzxQ88ci2396qJFw3b8OG6B61cv7HNJAUWRZgiY01uHdwBcxk8r4NdSHaTcA3cFUO
         o/BREz3SnEt7bke/98mBa82r5/4exreoMNiqGDDG7kdYQ8Ux+ju8iUKECcJjeuTZOxXI
         QIbzRDQMYpjIltWftZ+DW0sbYFls444GtJ3vYCJv2rjAJ7YNicpCgOpO6SFPNhz9b4Eh
         Ncd/bsXFGT/NcrbVjbJLtuuAM0YrfoiNoPx8TqXnWYvfQGsmGVueTXSUBd6lwAZ9uLqx
         06GA==
X-Gm-Message-State: AOAM531mjHsFzByXn8/ItB71on6zW0q5hNjRUSrxHu2gOgxhEjs2kZi1
        Wdj2SUnYwNaszs0fXosJnBIQfg==
X-Google-Smtp-Source: ABdhPJy9oB6kLzcAg1sewJLV1RILKrMKpLEU6QhO81UMhCYhgQ/e+CubBnLh6m1Z81OYwzB8g7HTkQ==
X-Received: by 2002:a65:4782:: with SMTP id e2mr3883245pgs.93.1616604229355;
        Wed, 24 Mar 2021 09:43:49 -0700 (PDT)
Received: from lbrmn-lnxub113.ric.broadcom.net ([192.19.228.250])
        by smtp.gmail.com with ESMTPSA id x190sm3099541pfx.166.2021.03.24.09.43.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Mar 2021 09:43:48 -0700 (PDT)
Subject: Re: [PATCH 1/4] dt-bindings: mmc: iproc-sdhci: Convert to json-schema
To:     Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Rob Herring <robh@kernel.org>
Cc:     Nicolas Saenz Julienne <nsaenz@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-mmc@vger.kernel.org,
        devicetree@vger.kernel.org, bcm-kernel-feedback-list@broadcom.com,
        linux-rpi-kernel@lists.infradead.org,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>, f.fainelli@gmail.com,
        phil@raspberrypi.com, tim.gover@raspberrypi.com,
        adrian.hunter@intel.com, alcooperx@gmail.com,
        linux-kernel@vger.kernel.org
References: <20210322185816.27582-1-nsaenz@kernel.org>
 <20210322185816.27582-2-nsaenz@kernel.org>
 <0e98588e-65f1-6839-1fcd-584b480a31bd@broadcom.com>
 <20210323210812.GA1318204@robh.at.kernel.org>
 <c1989e31501ccfb6e1350d467d4f26089bfcfb64.camel@suse.de>
 <28a133d2-c713-4bce-271c-5fa228d830ca@broadcom.com>
 <9de20a5960e029b8842dc026be3be85295647175.camel@suse.de>
From:   Scott Branden <scott.branden@broadcom.com>
Message-ID: <bacfa0ef-dcb1-150a-4d10-46524a0a7082@broadcom.com>
Date:   Wed, 24 Mar 2021 09:43:45 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <9de20a5960e029b8842dc026be3be85295647175.camel@suse.de>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
        boundary="000000000000ddaa7605be4b002d"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

--000000000000ddaa7605be4b002d
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit

On 2021-03-24 9:35 a.m., Nicolas Saenz Julienne wrote:
> On Wed, 2021-03-24 at 09:27 -0700, Scott Branden wrote:
>> On 2021-03-23 2:24 p.m., Nicolas Saenz Julienne wrote:
>>> On Tue, 2021-03-23 at 15:08 -0600, Rob Herring wrote:
>>>> On Mon, Mar 22, 2021 at 12:11:29PM -0700, Scott Branden wrote:
>>>>> On 2021-03-22 11:58 a.m., Nicolas Saenz Julienne wrote:
>>>>>> Convert the brcm,iproc-sdhci binding to DT schema format using json-schema
>>>>>>
>>>>>> Signed-off-by: Nicolas Saenz Julienne <nsaenz@kernel.org>
>>>>>> ---
>>>>>>  .../bindings/mmc/brcm,iproc-sdhci.yaml        | 58 +++++++++++++++++++
>>>>>>  .../bindings/mmc/brcm,sdhci-iproc.txt         | 37 ------------
>>>>>>  2 files changed, 58 insertions(+), 37 deletions(-)
>>>>>>  create mode 100644 Documentation/devicetree/bindings/mmc/brcm,iproc-sdhci.yaml
>>>>>>  delete mode 100644 Documentation/devicetree/bindings/mmc/brcm,sdhci-iproc.txt
>>>>>>
>>>>>> diff --git a/Documentation/devicetree/bindings/mmc/brcm,iproc-sdhci.yaml b/Documentation/devicetree/bindings/mmc/brcm,iproc-sdhci.yaml
>>>>>> new file mode 100644
>>>>>> index 000000000000..19d84f3ef9e6
>>>>>> --- /dev/null
>>>>>> +++ b/Documentation/devicetree/bindings/mmc/brcm,iproc-sdhci.yaml
>>>>>> @@ -0,0 +1,58 @@
>>>>>> +# SPDX-License-Identifier: GPL-2.0
>>>>>> +%YAML 1.2
>>>>>> +---
>>>>>> +$id: http://devicetree.org/schemas/mmc/brcm,iproc-sdhci.yaml#
>>>>>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>>>>>> +
>>>>>> +title: Broadcom IPROC SDHCI controller
>>>>>> +
>>>>>> +maintainers:
>>>>>> +  - Nicolas Saenz Julienne <nsaenz@kernel.org>
>>>>> This is already covered in the MAINTAINERS section via "N:	iproc".
>>>>> M:	Ray Jui <ray.jui@broadcom.com>
>>>>>
>>>>> M:	Scott Branden <scott.branden@broadcom.com>
>>>>>
>>>>> M:	bcm-kernel-feedback-list@broadcom.com
>>>>
>>>> Maybe so, but still required here. The problem is there is no 
>>>> MAINTAINERS file in the DT only tree[1].
>>>
>>> Well in that case, if Scott and Ray are OK with it I'll add them.
>> I do not know what the "maintainers" section in the yaml file is used to indicate.
>> If it is maintainer for the driver then please add the duplicate of what is
>> already in the MAINTAINERS file.  If it is for maintainer of devicetrees that
>> use this driver then no need to add us.
> 
> From the dt bindings documentation:
> 
> maintainers
>   A DT specific property. Contains a list of email address(es)
>   for maintainers of this binding.
> 
> That's the maintainers for the bindings, not the devicetrees consuming them. I
> belive it makes sense for you guys to maintain it as it has a strong
> relationship to driver changes. But if you're not interested I'll do it myself.
Sure, you can add us as well.
> 
> Regards,
> Nicolas
> 


--000000000000ddaa7605be4b002d
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
Gk8wDQYJYIZIAWUDBAIBBQCggdQwLwYJKoZIhvcNAQkEMSIEIBnv6igRHhmDbuAl73NW7VJttv36
iz9mgBr+KhkZnktaMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTIx
MDMyNDE2NDM0OVowaQYJKoZIhvcNAQkPMVwwWjALBglghkgBZQMEASowCwYJYIZIAWUDBAEWMAsG
CWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQowCwYJKoZIhvcNAQEHMAsGCWCGSAFl
AwQCATANBgkqhkiG9w0BAQEFAASCAQBlOuuoo8vxCD9xrAq/CWVbt8vHcjmT9fLh+zQPqIaQv3Q9
VF6E8S3v7v/RaQftxerqgXkRbJLz/1HnfbPaqLXXNIwksv98F6vZlSoVEvSK5GWwxpB8RGSE4bv8
Rh7iprxuZkiNBem/8qJQc3tpVFcYxFMWzqmQibu2UZwhGWbqZcVVc9bhtrBb23GQhhwjt9RPuulW
7QBG0XJ0as2mO8vriFO1oT14BwlgNYS5nZ1I6o+7m/QbJn7PMxVu5t0kkxeomqL1klUD2wxZ/3mw
wcPsaUEoic+7FiE03dT+ij6q8sR4t6Pz8qUsZ9S7UQ/+5Faxz6R9gmLSfi06ypOEvRUa
--000000000000ddaa7605be4b002d--
