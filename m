Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45D9FC7EE22
	for <linux-mmc@archiver.kernel.org>; Sun, 14 May 2023 20:43:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229701AbjENUnC (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Sun, 14 May 2023 16:43:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229672AbjENUnB (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Sun, 14 May 2023 16:43:01 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BA8DE48
        for <linux-mmc@vger.kernel.org>; Sun, 14 May 2023 13:43:00 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id a640c23a62f3a-965ac4dd11bso2395753266b.2
        for <linux-mmc@vger.kernel.org>; Sun, 14 May 2023 13:43:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20221208; t=1684096978; x=1686688978;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=O9dvTSlniUVfCaSC8k/L21+kFYYDT3lk/DIP6ENR2s4=;
        b=llVR2huAlUigHQb08k844q7grcjOaj7bgGcET6x54m6ggUHbKoKfvFK2klcfJwnyQg
         mkcpYs2AjkdQHIYlT3kDp1FUxpYXpZAQQ59xW78CTBadgxECpzUp9LoYeBGhTDu1IDGg
         pHPRCsNnUlVx2/9t9Z27i+JVT4+6NrgCxL5Q1mUwcPk1bT+PirfdqRZO9PfrMD7Yx5jq
         3e6Rz4jDI8nAFD6yy0NQ0LuptDF5/Mdc7Bz5DbuxeNI7FelRKk3DIyQZGNMQdgqL79eX
         sLfcUaqi5pUalPOeQiuinNSklPSOgtAHZj3sqNA5OcNnA7RU1LfuIkXwt1RyNxG75Vcu
         yKlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684096978; x=1686688978;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=O9dvTSlniUVfCaSC8k/L21+kFYYDT3lk/DIP6ENR2s4=;
        b=RaLq9aqMQniDE84nr5RsNXLNvNzvqS+oDJwBZOxVFzLMv7auIILOixgblPPg4cS/md
         mRiPE+V9DVZMiLn2h+ZwEWKUJHDt+3ezIng21ovlOSLSujJiUS5Lm7fkQ2ntFX/XPNo2
         3RdUk1mmmi4RAtrkBLAdMveS1f+LHSG/13fjadvqdT5P3ouE0+zD96N5vnGt4nQTDrk3
         fb/Vt2sinCzOHI/pILLLgVXrP1GgLszjqkDHoeizdzZQ/t3+jZPaRUyv8eEzibTRl2jJ
         9/ISahYsVZd8BD0256FJOGYZ+gvro9R0Q4pbOUT8EKC/tk3pRFwtrxHrceyI8w760TOG
         YeOw==
X-Gm-Message-State: AC+VfDwCDD0ZFlDc3Ep8fT48Zwwtb+WdwzCUyqAM/Vp6m64XNu3S/bOq
        GeRYm7bDZ62UBR5n8LEFo9UWlEsdfsUt9WzIViU=
X-Google-Smtp-Source: ACHHUZ62HeSMNAqKI3//QVu45v+vCwf+3JiHi6LmkZSWBkwJ72pTau2OTKnwJCtyHBLXNCTjitO9qhRwNpG6yc09ffA=
X-Received: by 2002:a17:907:806:b0:953:47fc:3f0b with SMTP id
 wv6-20020a170907080600b0095347fc3f0bmr24871963ejb.53.1684096978431; Sun, 14
 May 2023 13:42:58 -0700 (PDT)
MIME-Version: 1.0
References: <CAFBinCD0RT0p-jk86W0JuMT3ufohRh1RqWCcM35DKZJpuc10HQ@mail.gmail.com>
 <CAPDyKFqgYnBfm-NespEZF8AJ5Ou4Bya8jLfVEnfyZvfAZ05Q7Q@mail.gmail.com>
 <CAFBinCDjPJHEhN-Jx3DhhhHJ3yi8oEoW7u4-Ld6Rd1+W826ttA@mail.gmail.com> <CAPDyKFqKSWJkJwgCO89jgKQ6AB==P9BWkuX6XtKj=ASOH15y9g@mail.gmail.com>
In-Reply-To: <CAPDyKFqKSWJkJwgCO89jgKQ6AB==P9BWkuX6XtKj=ASOH15y9g@mail.gmail.com>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Sun, 14 May 2023 22:42:46 +0200
Message-ID: <CAFBinCDwgYw3v31hP4AtV3+Z1o+esDqMKugRwMMMLqSX0Acjzw@mail.gmail.com>
Subject: Re: Odroid-C1 regression with commit 4bc31edebde5 ("mmc: core: Set HS
 clock speed before sending HS CMD13")
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     linux-amlogic@lists.infradead.org, linux-mmc@vger.kernel.org,
        Brian Norris <briannorris@chromium.org>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Luca Weiss <luca@z3ntu.xyz>
Content-Type: multipart/mixed; boundary="0000000000002ac84205fbad6269"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

--0000000000002ac84205fbad6269
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Ulf,

On Thu, May 11, 2023 at 12:43=E2=80=AFPM Ulf Hansson <ulf.hansson@linaro.or=
g> wrote:
[...]
> > Indeed, removing mmc_set_clock() from mmc_select_hs200() also makes my
> > eMMC appear again on top of Linux 6.4-rc1.
> > See the attached diff in case it's not fully clear which
> > mmc_set_clock() call I removed.
>
> Thanks for the update! Removing that call restores mmc_select_hs200()
> to the previous behaviour - so thanks for confirming that this is
> working.
>
> However, to find the proper solution, I think we need to understand
> why we are hanging in the meson-mx-sdhc driver first. Here's a couple
> of follow up questions from me:
>
> 1) Before calling mmc_set_clock() what is the actual clock rate that
> has been set by the meson driver?
>
> 2) Does the call to mmc_set_clock() return or hang? Can we verify that
> the clock gets set correctly?
I used the attached diff to answer these two questions. See the
following log extract (full log is attached):
meson-mx-sdhc c1108e00.mmc: Trying to set MMC clock to 400000Hz
meson-mx-sdhc c1108e00.mmc: Actual MMC clock to 399812Hz
mmc1: mmc_select_hs200 switching to clock from card->ext_csd.hs_max_dtr...
meson-mx-sdhc c1108e00.mmc: Trying to set MMC clock to 52000000Hz
meson-mx-sdhc c1108e00.mmc: Actual MMC clock to 51000000Hz
mmc1: mmc_select_hs200 mmc_set_clock returned

> 3) If 2) seems to work above, we need to figure out why
> mmc_switch_status() is hanging. If there is a problem with the eMMC
> card responding in-correctly, the host driver should return with an
> error code, right?
You're right: it's indeed hanging in mmc_switch_status()
I don't get any interrupts (timeout, CRC error, ...) for it.
Do you have any suggestions what to check next?


Best regards,
Martin

--0000000000002ac84205fbad6269
Content-Type: text/x-patch; charset="US-ASCII"; 
	name="error-prints-to-identify-why-hs200-switch-hangs.diff"
Content-Disposition: attachment; 
	filename="error-prints-to-identify-why-hs200-switch-hangs.diff"
Content-Transfer-Encoding: base64
Content-ID: <f_lhnvryoz1>
X-Attachment-Id: f_lhnvryoz1

ZGlmZiAtLWdpdCBhL2RyaXZlcnMvbW1jL2NvcmUvbW1jLmMgYi9kcml2ZXJzL21tYy9jb3JlL21t
Yy5jCmluZGV4IDg5Y2Q0OGZjZWM3OS4uZWYyOTg2ZmY0NTI4IDEwMDY0NAotLS0gYS9kcml2ZXJz
L21tYy9jb3JlL21tYy5jCisrKyBiL2RyaXZlcnMvbW1jL2NvcmUvbW1jLmMKQEAgLTE1MDAsNyAr
MTUwMCwxMSBAQCBzdGF0aWMgaW50IG1tY19zZWxlY3RfaHMyMDAoc3RydWN0IG1tY19jYXJkICpj
YXJkKQogCQlvbGRfdGltaW5nID0gaG9zdC0+aW9zLnRpbWluZzsKIAkJb2xkX2Nsb2NrID0gaG9z
dC0+aW9zLmNsb2NrOwogCQltbWNfc2V0X3RpbWluZyhob3N0LCBNTUNfVElNSU5HX01NQ19IUzIw
MCk7CisJCXByX2VycigiJXM6ICVzIHN3aXRjaGluZyB0byBjbG9jayBmcm9tIGNhcmQtPmV4dF9j
c2QuaHNfbWF4X2R0ci4uLlxuIiwgbW1jX2hvc3RuYW1lKGNhcmQtPmhvc3QpLAorCQkgICAgICAg
X19mdW5jX18pOwogCQltbWNfc2V0X2Nsb2NrKGNhcmQtPmhvc3QsIGNhcmQtPmV4dF9jc2QuaHNf
bWF4X2R0cik7CisJCXByX2VycigiJXM6ICVzIG1tY19zZXRfY2xvY2sgcmV0dXJuZWRcbiIsIG1t
Y19ob3N0bmFtZShjYXJkLT5ob3N0KSwKKwkJICAgICAgIF9fZnVuY19fKTsKIAogCQkvKgogCQkg
KiBGb3IgSFMyMDAsIENSQyBlcnJvcnMgYXJlIG5vdCBhIHJlbGlhYmxlIHdheSB0byBrbm93IHRo
ZQpAQCAtMTUwOCw2ICsxNTEyLDggQEAgc3RhdGljIGludCBtbWNfc2VsZWN0X2hzMjAwKHN0cnVj
dCBtbWNfY2FyZCAqY2FyZCkKIAkJICogdHVuaW5nIHdpbGwgZmFpbCBhbmQgdGhlIHJlc3VsdCBl
bmRzIHVwIHRoZSBzYW1lLgogCQkgKi8KIAkJZXJyID0gbW1jX3N3aXRjaF9zdGF0dXMoY2FyZCwg
ZmFsc2UpOworCQlwcl9lcnIoIiVzOiAlcyBzdGF0dXMgYWZ0ZXIgbW1jX3NldF9jbG9jazogJWRc
biIsIG1tY19ob3N0bmFtZShjYXJkLT5ob3N0KSwKKwkJICAgICAgIF9fZnVuY19fLCBlcnIpOwog
CiAJCS8qCiAJCSAqIG1tY19zZWxlY3RfdGltaW5nKCkgYXNzdW1lcyB0aW1pbmcgaGFzIG5vdCBj
aGFuZ2VkIGlmCmRpZmYgLS1naXQgYS9kcml2ZXJzL21tYy9ob3N0L21lc29uLW14LXNkaGMtbW1j
LmMgYi9kcml2ZXJzL21tYy9ob3N0L21lc29uLW14LXNkaGMtbW1jLmMKaW5kZXggODc5OWY0N2Vk
ZjIzLi4xMDRmMDAyNzU5NGYgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvbW1jL2hvc3QvbWVzb24tbXgt
c2RoYy1tbWMuYworKysgYi9kcml2ZXJzL21tYy9ob3N0L21lc29uLW14LXNkaGMtbW1jLmMKQEAg
LTI3Miw2ICsyNzIsOCBAQCBzdGF0aWMgaW50IG1lc29uX214X3NkaGNfc2V0X2NsayhzdHJ1Y3Qg
bW1jX2hvc3QgKm1tYywgc3RydWN0IG1tY19pb3MgKmlvcykKIAogCW1lc29uX214X3NkaGNfZGlz
YWJsZV9jbGtzKG1tYyk7CiAKKwlkZXZfZXJyKG1tY19kZXYobW1jKSwgIlRyeWluZyB0byBzZXQg
TU1DIGNsb2NrIHRvICV1SHpcbiIsIGlvcy0+Y2xvY2spOworCiAJaWYgKGlvcy0+Y2xvY2spIHsK
IAkJcmV0ID0gY2xrX3NldF9yYXRlKGhvc3QtPnNkX2NsaywgaW9zLT5jbG9jayk7CiAJCWlmIChy
ZXQpIHsKQEAgLTMxNyw2ICszMTksOCBAQCBzdGF0aWMgaW50IG1lc29uX214X3NkaGNfc2V0X2Ns
ayhzdHJ1Y3QgbW1jX2hvc3QgKm1tYywgc3RydWN0IG1tY19pb3MgKmlvcykKIAkJbW1jLT5hY3R1
YWxfY2xvY2sgPSAwOwogCX0KIAorCWRldl9lcnIobW1jX2RldihtbWMpLCAiQWN0dWFsIE1NQyBj
bG9jayB0byAldUh6XG4iLCBtbWMtPmFjdHVhbF9jbG9jayk7CisKIAlyZXR1cm4gMDsKIH0KIApA
QCAtNTYyLDYgKzU2Niw5IEBAIHN0YXRpYyBpcnFyZXR1cm5fdCBtZXNvbl9teF9zZGhjX2lycShp
bnQgaXJxLCB2b2lkICpkYXRhKQogCWlmICghKGljdGwgJiBpc3RhKSkKIAkJcmV0dXJuIElSUV9O
T05FOwogCisJZGV2X2VycihtbWNfZGV2KGhvc3QtPm1tYyksICJDTUQlZCBJU1RBOiAweCUwOHgs
IElDVEw6IDB4JTA4eFxuIiwKKwkJCWNtZC0+b3Bjb2RlLCBpc3RhLCBpY3RsKTsKKwogCWlmIChp
c3RhICYgTUVTT05fU0RIQ19JU1RBX1JYRklGT19GVUxMIHx8CiAJICAgIGlzdGEgJiBNRVNPTl9T
REhDX0lTVEFfVFhGSUZPX0VNUFRZKQogCQljbWQtPmVycm9yID0gLUVJTzsK
--0000000000002ac84205fbad6269--
