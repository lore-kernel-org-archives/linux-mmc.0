Return-Path: <SRS0=Fy1S=6Y=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE27BC54E8E
	for <linux-mmc@archiver.kernel.org>; Sun, 10 May 2020 20:52:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8E8462098B
	for <linux-mmc@archiver.kernel.org>; Sun, 10 May 2020 20:52:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="l8bxUB+O"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729477AbgEJUwj (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Sun, 10 May 2020 16:52:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729377AbgEJUwi (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Sun, 10 May 2020 16:52:38 -0400
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20E50C061A0C;
        Sun, 10 May 2020 13:52:38 -0700 (PDT)
Received: by mail-ej1-x644.google.com with SMTP id n17so6169548ejh.7;
        Sun, 10 May 2020 13:52:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XN9HVfx2Nq8ELSLfKqyYdBqRcQTahj+sAQBqI9rxLfw=;
        b=l8bxUB+OrW+TcvrPvGlUmvJXPn//BVuK9BnU2b1VBHsgiYWVYgOMxZ0VzOrllgvIn/
         99E02MCrZNtOycINWxbpLqzL1nJh8mgIGGZKezFiejkQ62ae3u6kZ/VBXRwzbbyXJKTs
         wSseBhqSkgQwTG5qaUTYI63lji6hBJU47bfO56CtufPSsTXriT4bBCRlxosqIB27hVf8
         EM4xsKQFqq6jBv1V5qBjWaitxMrVNFR0MIS+cr7T/x4ilLFGZwM0vUsb6+jdaIyMpueQ
         OjLER+XdxGM50xXwbhnnu9XApbJxAifm+KFKEHOqAQwopk50CnoWfOOlEM81B43SwUqo
         BV8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XN9HVfx2Nq8ELSLfKqyYdBqRcQTahj+sAQBqI9rxLfw=;
        b=tfvyab2HN7bPDTC+jNlsibE0HQVmqWSP/PK/rz62BhHs71M/jPmDWSnDZ0KzRHyRCX
         tLAyUqDQC8KPLFdsMA915TsJKcUq1ZDpmIbW9msx/9zKj++Frm/OYJ8/OIzO5Af71xIw
         MCQDdhIaD9Lqy8Wgw2O/iFh8CX+eTM1VEDOQxqOvHaSYRS9n4X0bR+XAZdORo94iZFIE
         LMmT1B0UoModlRE/bVnIbaL1mSO4X7M4KSINa6O7tq8hnIXgKMjBEOajXCoEwxLHxzYd
         9+bOhBD0/a0nWNAOHci+NKOxQlU0F+cRA+mBRyUGYOl9wkIFTKCIuU8bJPwhrBlmx+R8
         Kt7w==
X-Gm-Message-State: AGi0PuZAYtOtjz8kQ6K7Zjd4xPj0PepXdsewaUMODgShnm7DHjV83YKk
        yRimFr+gqXtCXnF5MJLp5vKDgLfPNQwL0HEFB3w=
X-Google-Smtp-Source: APiQypIdnABmp04ng7WPsf9YyXLEhUeTIbLwh5QFHCckGD97WlwESUQk7tqPdySBT967r2TZPgbM1PTFvacacdeQ72k=
X-Received: by 2002:a17:906:4048:: with SMTP id y8mr10685706ejj.258.1589143956392;
 Sun, 10 May 2020 13:52:36 -0700 (PDT)
MIME-Version: 1.0
References: <20200428210229.703309-1-martin.blumenstingl@googlemail.com>
 <20200428210229.703309-3-martin.blumenstingl@googlemail.com>
 <1jlfmdi9uw.fsf@starbuckisacylon.baylibre.com> <CAPDyKFoEh8qKYFONo1SHnvwhDwjUa5bMnnT1Kbu8=4rd=T-8Kg@mail.gmail.com>
 <1jh7x1i3hj.fsf@starbuckisacylon.baylibre.com> <CAPDyKFq_USCNNps3s4+C_1hriycrxtRMKJvnPFcP59CZmLXbGw@mail.gmail.com>
 <1j1rnygye6.fsf@starbuckisacylon.baylibre.com>
In-Reply-To: <1j1rnygye6.fsf@starbuckisacylon.baylibre.com>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Sun, 10 May 2020 22:52:25 +0200
Message-ID: <CAFBinCAPGwb4YKJvUSyvzSC7hpVO0z-Ju_pBWx-06QzYXc0orw@mail.gmail.com>
Subject: Re: [PATCH v6 2/2] mmc: host: meson-mx-sdhc: new driver for the
 Amlogic Meson SDHC host
To:     Jerome Brunet <jbrunet@baylibre.com>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>,
        "open list:ARM/Amlogic Meson..." <linux-amlogic@lists.infradead.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        DTML <devicetree@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Jianxin Pan <jianxin.pan@amlogic.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        yinxin_1989@aliyun.com,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        lnykww@gmail.com, Anand Moon <linux.amoon@gmail.com>
Content-Type: multipart/mixed; boundary="00000000000004a71b05a55169bf"
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

--00000000000004a71b05a55169bf
Content-Type: text/plain; charset="UTF-8"

Hi Jerome,

On Tue, May 5, 2020 at 6:05 PM Jerome Brunet <jbrunet@baylibre.com> wrote:
[...]
> > 2. Keep the existing approach, with devm_clk_get(). I am fine with
> > this as well, we can always switch to 1) later on.
>
> I have a problem with this approach.
> The dt-bindings would include "#clock-cells = <1>" for a device that
> does not actually provide and only needs it has a temporary work around.
> Those bindings are supposed to be stable ...
actually I don't see a problem here because this specific MMC
controller has a clock controller built into it.
Rob also didn't see any problem with this when he reviewed the dt-bindings

> I have proposed 2 other short term solutions, let's see how it goes
since I was also curious how this turns out I first implemented your
suggestion to use a similar clk_hw registration style as
dwmac-meson8b.
That made the code easier to read - thank you for the suggestion!

On top of that I switched from clk_hw_onecell_data to directly
accessing "clk_hw.clk".
Unfortunately the diffstat is not as great as I hoped, it saves 21
lines (11 in the driver code, 6 in the soc.dtsi, 5 in the dt-bindings)
Once devm_clk_hw_get_clk() is implemented 8 lines have to be added
again for error checking.
I attached the patch for the drivers/mmc/host/meson-mx-sdhc* parts if
you are curious (it'll apply only on top of my github branch, not on
this series).

Please let me know if you want me to submit an updated series where I
directly access "clk_hw.clk" to get the "struct clk" or if I should
keep clk_hw_onecell_data.
If it's the former then I'll also add a TODO comment for the
conversion to devm_clk_hw_get_clk() so it's easy to find.


Regards,
Martin

--00000000000004a71b05a55169bf
Content-Type: text/x-patch; charset="US-ASCII"; name="temp.diff"
Content-Disposition: attachment; filename="temp.diff"
Content-Transfer-Encoding: base64
Content-ID: <f_ka1j1f5g0>
X-Attachment-Id: f_ka1j1f5g0

ZGlmZiAtLWdpdCBhL2RyaXZlcnMvbW1jL2hvc3QvbWVzb24tbXgtc2RoYy1jbGtjLmMgYi9kcml2
ZXJzL21tYy9ob3N0L21lc29uLW14LXNkaGMtY2xrYy5jCmluZGV4IGEzNjQ4M2Q4NTlmOC4uZDJl
MzY1MTdlMGY2IDEwMDY0NAotLS0gYS9kcml2ZXJzL21tYy9ob3N0L21lc29uLW14LXNkaGMtY2xr
Yy5jCisrKyBiL2RyaXZlcnMvbW1jL2hvc3QvbWVzb24tbXgtc2RoYy1jbGtjLmMKQEAgLTcsNiAr
Nyw3IEBACiAKICNpbmNsdWRlIDxkdC1iaW5kaW5ncy9jbG9jay9tZXNvbi1teC1zZGhjLWNsa2Mu
aD4KIAorI2luY2x1ZGUgPGxpbnV4L2Nsay5oPgogI2luY2x1ZGUgPGxpbnV4L2Nsay1wcm92aWRl
ci5oPgogI2luY2x1ZGUgPGxpbnV4L2RldmljZS5oPgogI2luY2x1ZGUgPGxpbnV4L3BsYXRmb3Jt
X2RldmljZS5oPgpAQCAtMjIsNyArMjMsNiBAQCBzdHJ1Y3QgbWVzb25fbXhfc2RoY19jbGtjIHsK
IAlzdHJ1Y3QgY2xrX2dhdGUJCQl0eF9jbGtfZW47CiAJc3RydWN0IGNsa19nYXRlCQkJcnhfY2xr
X2VuOwogCXN0cnVjdCBjbGtfZ2F0ZQkJCXNkX2Nsa19lbjsKLQlzdHJ1Y3QgY2xrX2h3X29uZWNl
bGxfZGF0YQlod19vbmVjZWxsX2RhdGE7CiB9OwogCiBzdGF0aWMgY29uc3Qgc3RydWN0IGNsa19w
YXJlbnRfZGF0YSBtZXNvbl9teF9zZGhjX3NyY19zZWxfcGFyZW50c1s0XSA9IHsKQEAgLTgzLDE3
ICs4MywxNCBAQCBzdGF0aWMgaW50IG1lc29uX214X3NkaGNfZ2F0ZV9jbGtfaHdfcmVnaXN0ZXIo
c3RydWN0IGRldmljZSAqZGV2LAogCQkJCQkgICAgICZjbGtfZ2F0ZV9vcHMsIGh3KTsKIH0KIAot
aW50IG1lc29uX214X3NkaGNfcmVnaXN0ZXJfY2xrYyhzdHJ1Y3QgZGV2aWNlICpkZXYsIHZvaWQg
X19pb21lbSAqYmFzZSkKK2ludCBtZXNvbl9teF9zZGhjX3JlZ2lzdGVyX2Nsa2Moc3RydWN0IGRl
dmljZSAqZGV2LCB2b2lkIF9faW9tZW0gKmJhc2UsCisJCQkJc3RydWN0IGNsa19idWxrX2RhdGEg
KmNsa19idWxrX2RhdGEpCiB7CiAJc3RydWN0IGNsa19wYXJlbnRfZGF0YSBkaXZfcGFyZW50ID0g
eyAwIH07Ci0Jc3RydWN0IGNsa19od19vbmVjZWxsX2RhdGEgKm9uZWNlbGxfZGF0YTsKIAlzdHJ1
Y3QgbWVzb25fbXhfc2RoY19jbGtjICpjbGtjX2RhdGE7CiAJaW50IHJldDsKIAotCWNsa2NfZGF0
YSA9IGRldm1fa3phbGxvYyhkZXYsIHN0cnVjdF9zaXplKGNsa2NfZGF0YSwKLQkJCQkJCSAgaHdf
b25lY2VsbF9kYXRhLmh3cywKLQkJCQkJCSAgTUVTT05fU0RIQ19OVU1fQlVJTFRJTl9DTEtTKSwK
LQkJCQkgR0ZQX0tFUk5FTCk7CisJY2xrY19kYXRhID0gZGV2bV9remFsbG9jKGRldiwgc2l6ZW9m
KCpjbGtjX2RhdGEpLCBHRlBfS0VSTkVMKTsKIAlpZiAoIWNsa2NfZGF0YSkKIAkJcmV0dXJuIC1F
Tk9NRU07CiAKQEAgLTE1MCwxNiArMTQ3LDE0IEBAIGludCBtZXNvbl9teF9zZGhjX3JlZ2lzdGVy
X2Nsa2Moc3RydWN0IGRldmljZSAqZGV2LCB2b2lkIF9faW9tZW0gKmJhc2UpCiAJaWYgKHJldCkK
IAkJcmV0dXJuIHJldDsKIAotCW9uZWNlbGxfZGF0YSA9ICZjbGtjX2RhdGEtPmh3X29uZWNlbGxf
ZGF0YTsKLQlvbmVjZWxsX2RhdGEtPmh3c1tTREhDX0NMS0lEX1NSQ19TRUxdID0gJmNsa2NfZGF0
YS0+c3JjX3NlbC5odzsKLQlvbmVjZWxsX2RhdGEtPmh3c1tTREhDX0NMS0lEX0RJVl0gPSAmY2xr
Y19kYXRhLT5kaXYuaHc7Ci0Jb25lY2VsbF9kYXRhLT5od3NbU0RIQ19DTEtJRF9NT0RfQ0xLXSA9
ICZjbGtjX2RhdGEtPm1vZF9jbGtfZW4uaHc7Ci0Jb25lY2VsbF9kYXRhLT5od3NbU0RIQ19DTEtJ
RF9TRF9DTEtdID0gJmNsa2NfZGF0YS0+c2RfY2xrX2VuLmh3OwotCW9uZWNlbGxfZGF0YS0+aHdz
W1NESENfQ0xLSURfVFhfQ0xLXSA9ICZjbGtjX2RhdGEtPnR4X2Nsa19lbi5odzsKLQlvbmVjZWxs
X2RhdGEtPmh3c1tTREhDX0NMS0lEX1JYX0NMS10gPSAmY2xrY19kYXRhLT5yeF9jbGtfZW4uaHc7
CisJLyoKKwkgKiBUT0RPOiBSZXBsYWNlIGNsa19ody5jbGsgd2l0aCBkZXZtX2Nsa19od19nZXRf
Y2xrKCkgb25jZSB0aGF0IGlzCisJICogYXZhaWxhYmxlLgorCSAqLworCWNsa19idWxrX2RhdGFb
MF0uY2xrID0gY2xrY19kYXRhLT5tb2RfY2xrX2VuLmh3LmNsazsKKwljbGtfYnVsa19kYXRhWzFd
LmNsayA9IGNsa2NfZGF0YS0+c2RfY2xrX2VuLmh3LmNsazsKKwljbGtfYnVsa19kYXRhWzJdLmNs
ayA9IGNsa2NfZGF0YS0+dHhfY2xrX2VuLmh3LmNsazsKKwljbGtfYnVsa19kYXRhWzNdLmNsayA9
IGNsa2NfZGF0YS0+cnhfY2xrX2VuLmh3LmNsazsKIAotCW9uZWNlbGxfZGF0YS0+bnVtID0gTUVT
T05fU0RIQ19OVU1fQlVJTFRJTl9DTEtTOwotCi0JcmV0dXJuIGRldm1fb2ZfY2xrX2FkZF9od19w
cm92aWRlcihkZXYsIG9mX2Nsa19od19vbmVjZWxsX2dldCwKLQkJCQkJICAgb25lY2VsbF9kYXRh
KTsKKwlyZXR1cm4gMDsKIH0KZGlmZiAtLWdpdCBhL2RyaXZlcnMvbW1jL2hvc3QvbWVzb24tbXgt
c2RoYy5jIGIvZHJpdmVycy9tbWMvaG9zdC9tZXNvbi1teC1zZGhjLmMKaW5kZXggM2M1NGQ1Zjkx
ZmJjLi4zMjI1NzA1NzBjOTggMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvbW1jL2hvc3QvbWVzb24tbXgt
c2RoYy5jCisrKyBiL2RyaXZlcnMvbW1jL2hvc3QvbWVzb24tbXgtc2RoYy5jCkBAIC04MDMsMTYg
KzgwMyw3IEBAIHN0YXRpYyBpbnQgbWVzb25fbXhfc2RoY19wcm9iZShzdHJ1Y3QgcGxhdGZvcm1f
ZGV2aWNlICpwZGV2KQogCiAJbWVzb25fbXhfc2RoY19pbml0X2h3KG1tYyk7CiAKLQlyZXQgPSBt
ZXNvbl9teF9zZGhjX3JlZ2lzdGVyX2Nsa2MoZGV2LCBiYXNlKTsKLQlpZiAocmV0KQotCQlnb3Rv
IGVycl9kaXNhYmxlX3BjbGs7Ci0KLQlob3N0LT5idWxrX2Nsa3NbMF0uaWQgPSAibW9kX2NsayI7
Ci0JaG9zdC0+YnVsa19jbGtzWzFdLmlkID0gInNkX2NsayI7Ci0JaG9zdC0+YnVsa19jbGtzWzJd
LmlkID0gInR4X2NsayI7Ci0JaG9zdC0+YnVsa19jbGtzWzNdLmlkID0gInJ4X2NsayI7Ci0JcmV0
ID0gZGV2bV9jbGtfYnVsa19nZXQoZGV2LCBNRVNPTl9TREhDX05VTV9CVUxLX0NMS1MsCi0JCQkJ
aG9zdC0+YnVsa19jbGtzKTsKKwlyZXQgPSBtZXNvbl9teF9zZGhjX3JlZ2lzdGVyX2Nsa2MoZGV2
LCBiYXNlLCBob3N0LT5idWxrX2Nsa3MpOwogCWlmIChyZXQpCiAJCWdvdG8gZXJyX2Rpc2FibGVf
cGNsazsKIApkaWZmIC0tZ2l0IGEvZHJpdmVycy9tbWMvaG9zdC9tZXNvbi1teC1zZGhjLmggYi9k
cml2ZXJzL21tYy9ob3N0L21lc29uLW14LXNkaGMuaAppbmRleCAyYWExZTQ0MDExNzMuLjIzMGU4
ZmJlNmIzZiAxMDA2NDQKLS0tIGEvZHJpdmVycy9tbWMvaG9zdC9tZXNvbi1teC1zZGhjLmgKKysr
IGIvZHJpdmVycy9tbWMvaG9zdC9tZXNvbi1teC1zZGhjLmgKQEAgLTEzMyw2ICsxMzMsOSBAQAog
CSNkZWZpbmUgTUVTT05fU0RIQ19DTEsyX1JYX0NMS19QSEFTRQkJCUdFTk1BU0soMTEsIDApCiAJ
I2RlZmluZSBNRVNPTl9TREhDX0NMSzJfU0RfQ0xLX1BIQVNFCQkJR0VOTUFTSygyMywgMTIpCiAK
LWludCBtZXNvbl9teF9zZGhjX3JlZ2lzdGVyX2Nsa2Moc3RydWN0IGRldmljZSAqZGV2LCB2b2lk
IF9faW9tZW0gKmJhc2UpOworc3RydWN0IGNsa19idWxrX2RhdGE7CisKK2ludCBtZXNvbl9teF9z
ZGhjX3JlZ2lzdGVyX2Nsa2Moc3RydWN0IGRldmljZSAqZGV2LCB2b2lkIF9faW9tZW0gKmJhc2Us
CisJCQkJc3RydWN0IGNsa19idWxrX2RhdGEgKmNsa19idWxrX2RhdGEpOwogCiAjZW5kaWYgLyog
X01FU09OX01YX1NESENfSF8gKi8K
--00000000000004a71b05a55169bf--
