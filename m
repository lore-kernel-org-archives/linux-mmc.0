Return-Path: <SRS0=ptsr=4A=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9753C352A4
	for <linux-mmc@archiver.kernel.org>; Wed, 12 Feb 2020 21:34:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 868EE24671
	for <linux-mmc@archiver.kernel.org>; Wed, 12 Feb 2020 21:34:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nGD0hPLa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728185AbgBLVe4 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 12 Feb 2020 16:34:56 -0500
Received: from mail-il1-f170.google.com ([209.85.166.170]:45596 "EHLO
        mail-il1-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727947AbgBLVez (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 12 Feb 2020 16:34:55 -0500
Received: by mail-il1-f170.google.com with SMTP id p8so3068175iln.12
        for <linux-mmc@vger.kernel.org>; Wed, 12 Feb 2020 13:34:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=w12Uk4zQnC+xm4GHXvQXhIjr4R0drGkqeHOjGRGVKRA=;
        b=nGD0hPLaoWfm9SsNH9PIixjvigE0si+TTOJZSuPm9GakC0PsjP2+CromiBVJRJwXdr
         Wf+QDToP8eLEw/BAbERoE0k0DTUWo54ksmpAKoDswmHBk6dgL1s+hd0qk0f2xMNNnMyq
         oY/ZpKnTeIMk4w7dCjuNbOJKnwRYybEdiSznacKKFQci0NRXiLHiNVSMz3Aqt2TDf/lf
         xqsBUlrXKQJ4DtBDPgzRJ8ZLB/Z81MsySrsbqDJJWoKN28efjrifveNddwG/06NqmPvF
         /k+EivcEm4RZqZkkX0kZDL+QKlmSiVuhR1kUbpJ/Q473uMQ6o/2dMujmNaZjtYlsc9YI
         014Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=w12Uk4zQnC+xm4GHXvQXhIjr4R0drGkqeHOjGRGVKRA=;
        b=PvHyCTQAm0AmxIS6CiT/ICDDtOM3NGTD4zHVuc5hz7VvulW0YmerisAA6v7kWuhRam
         DBCzkFoc0XFUDidpuz1+YGOus9hxjUkK6onmGsctMpWQdtCaAl0UmPLf3o4d/t5kkxds
         ZmaWQaVtg4nYtCmGKEVh2G+Z0vx3AwO9m7zTSqwvePBEminjY5ELB4zB8sccsDdMARBx
         DE8/MgXMnHS96iiPIoEqmOVOEcg+L1VYhq63U1qqcaJubzfqgWesS28ym2A3KMxtcrEy
         tX8hXjbm49dervKyT012t3EWO142aAyGl8/TYx99GNRqQrBZoMTGyJasqLMyqkZIduvU
         WqFA==
X-Gm-Message-State: APjAAAWWDnesm6dIuDzjNqvuwJxX44siNe67aPV2W/uhgMM7ItcS7f6I
        uQSKf2ZECAUcx8bYJ2vbjDubjlWxj8o2Pt/nmy2cKGuq
X-Google-Smtp-Source: APXvYqwxNhn/TKvKC6PNrZkWdLDtRBZtKFX4gCeAjjM39czv6n5yxbo1Y8awtBH3kVWiYJ3GSDsgrZ3AJzuNysP25yQ=
X-Received: by 2002:a92:3cc3:: with SMTP id j64mr11824282ilf.160.1581543295070;
 Wed, 12 Feb 2020 13:34:55 -0800 (PST)
MIME-Version: 1.0
From:   Patrick Oppenlander <patrick.oppenlander@gmail.com>
Date:   Thu, 13 Feb 2020 08:34:43 +1100
Message-ID: <CAEg67GnNdOBgq=gVH9fDTwT0-KM5+3g8Do5ZnW+y6Q0AY_302A@mail.gmail.com>
Subject: mmc-utils mmc tool reports incorrect cache size
To:     linux-mmc@vger.kernel.org
Content-Type: multipart/mixed; boundary="0000000000004cf39f059e67be65"
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

--0000000000004cf39f059e67be65
Content-Type: text/plain; charset="UTF-8"

Hi,

I recently noticed that 'mmc' reports cache size incorrectly. The unit
in the extended CSD is kilobits rather than kilobytes, so for a
display unit of 'KiB' it needs to be scaled appropriately.
Alternatively the unit could change to Kibit, but I think that's less
helpful.

I've attached a patch which fixes the issue & includes references to
the relevant parts of the JEDEC standard.

Hope someone finds this helpful,

Patrick

--0000000000004cf39f059e67be65
Content-Type: text/x-patch; charset="US-ASCII"; 
	name="0001-Scale-ext_csd-cache-size-from-kilobits-to-kilobytes.patch"
Content-Disposition: attachment; 
	filename="0001-Scale-ext_csd-cache-size-from-kilobits-to-kilobytes.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_k6jtzd6c0>
X-Attachment-Id: f_k6jtzd6c0

RnJvbSBmZDc0MTM3NDI3OGVjNjRiYjBjMjY3ODBkMDQzZmFiMGQ3YmNmNDBlIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBQYXRyaWNrIE9wcGVubGFuZGVyIDxwYXRyaWNrLm9wcGVubGFu
ZGVyQGdtYWlsLmNvbT4KRGF0ZTogTW9uLCA0IE5vdiAyMDE5IDEzOjUxOjEyICsxMTAwClN1Ympl
Y3Q6IFtQQVRDSF0gU2NhbGUgZXh0X2NzZCBjYWNoZSBzaXplIGZyb20ga2lsb2JpdHMgdG8ga2ls
b2J5dGVzCgpKRVNEODQtQjUxIDcuNC4zMCBDQUNIRV9TSVpFIFsyNTI6MjQ5XSBzdGF0ZXMgdGhh
dCAidGhlIHNpemUgaXMKaW5kaWNhdGVkIGFzIG11bHRpcGxlIG9mIGtpbG9iaXRzIi4gVGhpcyBp
cyBhbHNvIHN1cHBvcnRlZCBieSBUYWJsZSAzOSwKImUuTU1DIGludGVybmFsIHNpemVzIGFuZCBy
ZWxhdGVkIFVuaXRzIC8gR3JhbnVsYXJpdGllcyIgd2hpY2ggbGlzdHMKIjMyS2IgKD00S0IpIiBh
cyB0aGUgY2FjaGUgc2l6ZSBncmFudWxhcml0eSBmb3IgNEtpQiBuYXRpdmUgZGV2aWNlcy4KLS0t
CiBtbWNfY21kcy5jIHwgNCArKy0tCiAxIGZpbGUgY2hhbmdlZCwgMiBpbnNlcnRpb25zKCspLCAy
IGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL21tY19jbWRzLmMgYi9tbWNfY21kcy5jCmluZGV4
IGZiMzcxODkuLmExYjFkNzUgMTAwNjQ0Ci0tLSBhL21tY19jbWRzLmMKKysrIGIvbW1jX2NtZHMu
YwpAQCAtMTQxOSw4ICsxNDE5LDggQEAgaW50IGRvX3JlYWRfZXh0Y3NkKGludCBuYXJncywgY2hh
ciAqKmFyZ3YpCiAJCXByaW50ZigiUG93ZXIgb2ZmIG5vdGlmaWNhdGlvbiBbUE9XRVJfT0ZGX0xP
TkdfVElNRTogMHglMDJ4XVxuIiwKIAkJCWV4dF9jc2RbMjQ3XSk7CiAJCXByaW50ZigiQ2FjaGUg
U2l6ZSBbQ0FDSEVfU0laRV0gaXMgJWQgS2lCXG4iLAotCQkJZXh0X2NzZFsyNDldIDw8IDAgfCAo
ZXh0X2NzZFsyNTBdIDw8IDgpIHwKLQkJCShleHRfY3NkWzI1MV0gPDwgMTYpIHwgKGV4dF9jc2Rb
MjUyXSA8PCAyNCkpOworCQkJKGV4dF9jc2RbMjQ5XSA8PCAwIHwgKGV4dF9jc2RbMjUwXSA8PCA4
KSB8CisJCQkoZXh0X2NzZFsyNTFdIDw8IDE2KSB8IChleHRfY3NkWzI1Ml0gPDwgMjQpKSAvIDgp
OwogCX0KIAogCS8qIEE0NDE6IFJlc2VydmVkIFs1MDE6MjQ3XQotLSAKMi4yMy4wCgo=
--0000000000004cf39f059e67be65--
