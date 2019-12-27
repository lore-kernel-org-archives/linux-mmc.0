Return-Path: <SRS0=N3x8=2R=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_BASE64_TEXT,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95D28C2D0C6
	for <linux-mmc@archiver.kernel.org>; Fri, 27 Dec 2019 15:14:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6413A21582
	for <linux-mmc@archiver.kernel.org>; Fri, 27 Dec 2019 15:14:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="Ai47wkcb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726562AbfL0POu (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 27 Dec 2019 10:14:50 -0500
Received: from mout.gmx.net ([212.227.15.18]:39933 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726053AbfL0POu (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Fri, 27 Dec 2019 10:14:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1577459683;
        bh=7qQ0Y1xrC6ezRjCxNe+1ZcIa9kqGRH1F5c8tSfVfhc0=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
        b=Ai47wkcb+wyg+YNflUUDwxDCl4yYZhHEPGZAr71j+FrwMTYAsCxLhKzHWHWhMqclI
         UGn92Rr6VWmO2C+TZZHcMdCWJJd8YV4Jl2ZA4+lf+4qj92SM7fuTD34UT3j4AHkVui
         PCtH5k7hyuKX5r/jqcOuvL5l1ZkWhnyoPPmCn+/A=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from localhost.fritz.box ([62.216.209.247]) by mail.gmx.com
 (mrgmx005 [212.227.17.190]) with ESMTPSA (Nemesis) id
 1MzQkE-1jgFAh2xKS-00vOo0; Fri, 27 Dec 2019 16:14:43 +0100
From:   Peter Seiderer <ps.report@gmx.net>
To:     linux-mmc@vger.kernel.org
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Philipp Zabel <p.zabel@pengutronix.de>
Subject: [PATCH v1] mmc: sdhci: Increase sdhci_send_command timeout to 100ms
Date:   Fri, 27 Dec 2019 16:14:42 +0100
Message-Id: <20191227151442.9240-1-ps.report@gmx.net>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Transfer-Encoding: base64
X-Provags-ID: V03:K1:MRiGV2OVMG46BszOVAlCI3ELCpAKFKKV8fq9S53VuI1xszaKASZ
 wM3Krk4VQr4izfhYo8W09LWV5hWTW8n21Gr6dEPFDKZqXvj+2xUzdePt3o7pYGMnqlcxTi+
 Kk+Jv9RcPXZQ9xrEveqfaXFNoPY7ZEufAdqVpuE7CH490qfB6vp0MAkcQ2n1TsUDgob58Cz
 WVbzuYwX7McX71wLiXbMQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:c66w6sPNhLc=:QB4+LwaJDo6ll+l8luwu7i
 /MNWelIVd2cJlgGlnKVY/YJpHr+EKAIWwUYIqfnS8i0ZnrVOej5Wpbm+CFICeWbZ1n/XSNxkN
 AFfYHj4Tro78UgcdMGKakpBmroKhwhaExRM6LLHVBQQabPRZO0YY1hSn69ORwVbComKTdvYw1
 BzG8pF2W9HUynosMJhb2taMbuuR6SnwO1/8bywTbEkV8FUyOnHWUd23zEwZX4ArrRHI5rSZsY
 nVlAjTRPW9MVjFT01SWvQXWkghTAR3loL2Q0JeHvF6g5crdE9VuKGYh1aRk7daChsIw5NoPew
 fDxccZJCQQniACv5JSBZCtmfIzquS1gpff8w/Ed9sBkZQpgdfRYHlZsziuHdfweyhBMsakWhw
 DHpt3RryPsE5Xa9FmljyNrXLSp/O0PhhxoDbEehxRT4OXG6O/O1v8PXWuykJJ5rux00310Yyy
 vqfy34e5b7U1JoXWYy0aDBUwkjS3nBIFvw28oDUrgn5JTOCMIvTi5pwzeaz18YpETMzMSBigu
 Hgo3cyEYJp9ePIkgZoLDxsM257jlh4eQfI6ARsRbgT9xqLAsw9Z9saViOhhR012AKJDInp5yT
 gw4mILO5LeyLp4ZrS8VjWiSxkbY6wBB54RyMS51Ma7IHi2Nua6dHkJ5fB8NVzVy+dCtQ8ZUD7
 8BHfoy3rbVBB0ou43E/hyoxakcN5shR8Immm6+uis3+dVjcYn/T89OZHKGCK8tZY5oPR2ZUq/
 WgBIDpL3Jua2p5HtqdJDtOrzEjOdHg3Z23vyusdr/snOlw6w1OaU4mFR1DHIEzJR124rWSnpk
 GO/LTRNCfGeucnFmXOdyTyr/KSVaHkUXsNa6xpa/emfYg68YNb8pfxBY+4tiKI/x2nc/18SLW
 fwhaIcfpLHUP5bpP3LkZTA0xtCqtOXh3EiMzxeDKFnhtBpmgkCEO5EHxroMXhpS7ah9r1ofdQ
 rb6f32+yjnxPBGyEBbeeqOUPWGUjPNag4BX58ai82mDrZXtOep5gq3FNETU7tjYV1br0T0i6g
 7wj8ZtnSlisl4Ii9nK8MO/OZrEoUrcBcN5qfpvo3HfWobqF78+UHl3nWL0A2bZO9/qwruzOb4
 VTDo0yiK7EtSgqiI+83mAkRdRMWvCQeOb+MyD0M3ib58q0pmqRt0x8XjLkhxx7VTE/OzrrbHa
 TcDpQ6BvvmazozI0FKiDbkkQx8WHGYUzr8XDWxX9H9VrSF86OiCX1DBAIt+DWLC0WazFgG5/c
 TRVxqPkRmhmJDfp3KlRaP/8boRBSWDxxsmBOREA==
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Rml4ZXM6CgkkIG1tYyBib290cGFydCBlbmFibGUgMSAxIC9kZXYvbW1jYmxrMQpbIDIzMzkuMzI0
MDYyXSBtbWMxOiBDb250cm9sbGVyIG5ldmVyIHJlbGVhc2VkIGluaGliaXQgYml0KHMpLgpbIDIz
MzkuMzI5ODA4XSBtbWMxOiBzZGhjaTogPT09PT09PT09PT09IFNESENJIFJFR0lTVEVSIERVTVAg
PT09PT09PT09PT0KWyAyMzM5LjMzNjMzOV0gbW1jMTogc2RoY2k6IFN5cyBhZGRyOiAgMHgxMTA0
NDAwMCB8IFZlcnNpb246ICAweDAwMDAwMDAyClsgMjMzOS4zNDI5MzNdIG1tYzE6IHNkaGNpOiBC
bGsgc2l6ZTogIDB4MDAwMDAyMDAgfCBCbGsgY250OiAgMHgwMDAwMDAwMQpbIDIzMzkuMzQ5NDYw
XSBtbWMxOiBzZGhjaTogQXJndW1lbnQ6ICAweDAzYjM0ODAxIHwgVHJuIG1vZGU6IDB4MDAwMDAw
MTMKWyAyMzM5LjM1NjA0OF0gbW1jMTogc2RoY2k6IFByZXNlbnQ6ICAgMHgwMWZkODAwOCB8IEhv
c3QgY3RsOiAweDAwMDAwMDMxClsgMjMzOS4zNjI2MzddIG1tYzE6IHNkaGNpOiBQb3dlcjogICAg
IDB4MDAwMDAwMDIgfCBCbGsgZ2FwOiAgMHgwMDAwMDA4MApbIDIzMzkuMzY5MjMwXSBtbWMxOiBz
ZGhjaTogV2FrZS11cDogICAweDAwMDAwMDA4IHwgQ2xvY2s6ICAgIDB4MDAwMDAwMWYKWyAyMzM5
LjM3NTk0M10gbW1jMTogc2RoY2k6IFRpbWVvdXQ6ICAgMHgwMDAwMDAwZiB8IEludCBzdGF0OiAw
eDAwMDAwMDAwClsgMjMzOS4zODI1NDJdIG1tYzE6IHNkaGNpOiBJbnQgZW5hYjogIDB4MTE3ZjEw
MGIgfCBTaWcgZW5hYjogMHgxMTdmMTAwYgpbIDIzMzkuMzg5MjU3XSBtbWMxOiBzZGhjaTogQUNt
ZCBzdGF0OiAweDAwMDAwMDAwIHwgU2xvdCBpbnQ6IDB4MDAwMDAwMDMKWyAyMzM5LjM5NTg1Nl0g
bW1jMTogc2RoY2k6IENhcHM6ICAgICAgMHgwN2ViMDAwMCB8IENhcHNfMTogICAweDAwMDBhMDAw
ClsgMjMzOS40MDI1NzddIG1tYzE6IHNkaGNpOiBDbWQ6ICAgICAgIDB4MDAwMDA2MWIgfCBNYXgg
Y3VycjogMHgwMGZmZmZmZgpbIDIzMzkuNDA5MjkxXSBtbWMxOiBzZGhjaTogUmVzcFswXTogICAw
eDAwMDAwODAwIHwgUmVzcFsxXTogIDB4ZmZmZmZmZmYKWyAyMzM5LjQxNTg4OV0gbW1jMTogc2Ro
Y2k6IFJlc3BbMl06ICAgMHgzMjhmNTkwMyB8IFJlc3BbM106ICAweDAwMDAwOTAwClsgMjMzOS40
MjI2MDJdIG1tYzE6IHNkaGNpOiBIb3N0IGN0bDI6IDB4MDAwMDAwMDgKWyAyMzM5LjQyNzIwM10g
bW1jMTogc2RoY2k6IEFETUEgRXJyOiAgMHgwMDAwMDAwMCB8IEFETUEgUHRyOiAweDNmYzc5MjA4
ClsgMjMzOS40MzM5MTNdIG1tYzE6IHNkaGNpOiA9PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PQoKU3VnZ2VzdGVkLWJ5OiBQaGlsaXBwIFphYmVsIDxwLnphYmVsQHBl
bmd1dHJvbml4LmRlPgpTaWduZWQtb2ZmLWJ5OiBQZXRlciBTZWlkZXJlciA8cHMucmVwb3J0QGdt
eC5uZXQ+Ci0tLQogZHJpdmVycy9tbWMvaG9zdC9zZGhjaS5jIHwgNCArKy0tCiAxIGZpbGUgY2hh
bmdlZCwgMiBpbnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL2RyaXZl
cnMvbW1jL2hvc3Qvc2RoY2kuYyBiL2RyaXZlcnMvbW1jL2hvc3Qvc2RoY2kuYwppbmRleCAyNzUx
MDJjMGExYmYuLjAxMWIzZDMyMjgyNiAxMDA2NDQKLS0tIGEvZHJpdmVycy9tbWMvaG9zdC9zZGhj
aS5jCisrKyBiL2RyaXZlcnMvbW1jL2hvc3Qvc2RoY2kuYwpAQCAtMTM2NCw4ICsxMzY0LDggQEAg
dm9pZCBzZGhjaV9zZW5kX2NvbW1hbmQoc3RydWN0IHNkaGNpX2hvc3QgKmhvc3QsIHN0cnVjdCBt
bWNfY29tbWFuZCAqY21kKQogCSAgICBjbWQtPm9wY29kZSA9PSBNTUNfU1RPUF9UUkFOU01JU1NJ
T04pCiAJCWNtZC0+ZmxhZ3MgfD0gTU1DX1JTUF9CVVNZOwogCi0JLyogV2FpdCBtYXggMTAgbXMg
Ki8KLQl0aW1lb3V0ID0gMTA7CisJLyogV2FpdCBtYXggMTAwIG1zICovCisJdGltZW91dCA9IDEw
MDsKIAogCW1hc2sgPSBTREhDSV9DTURfSU5ISUJJVDsKIAlpZiAoc2RoY2lfZGF0YV9saW5lX2Nt
ZChjbWQpKQotLSAKMi4yNC4wCgo=
