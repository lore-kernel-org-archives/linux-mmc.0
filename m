From: Yousong Zhou <yszhou4tech@gmail.com>
Subject: Re: [linux-sunxi] Re: [RFC] mmc: core: Set clock before switching to
 highspeed mode.
Date: Tue, 8 Sep 2015 23:38:47 +0800
Message-ID: <CAECwjAjsi28gQ-iMZbEgFdoDoTcf0khnS0KRrzO1wnL1j0o0vQ@mail.gmail.com>
References: <1441448358-13129-1-git-send-email-yszhou4tech@gmail.com>
 <55EAF712.8090203@rock-chips.com> <55EB02FD.5040403@redhat.com>
 <55EB8508.9030009@rock-chips.com> <CAECwjAhe3g0T2icEExE_tBbZ2D1z+BpVNCd0dGZVNU=7zH-LHw@mail.gmail.com>
 <55EC4A31.4060605@rock-chips.com> <CAECwjAgLuskgyHv50GOVN8fGOmQz+jo9PLCAr-POpYH6AszWSg@mail.gmail.com>
 <55ED3695.2030101@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary=001a113d3c1e9cf582051f3e2a62
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-oi0-f49.google.com ([209.85.218.49]:33844 "EHLO
	mail-oi0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754740AbbIHPjI (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 8 Sep 2015 11:39:08 -0400
Received: by oiev17 with SMTP id v17so61036216oie.1
        for <linux-mmc@vger.kernel.org>; Tue, 08 Sep 2015 08:39:07 -0700 (PDT)
In-Reply-To: <55ED3695.2030101@redhat.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Hans de Goede <hdegoede@redhat.com>
Cc: shawn.lin@rock-chips.com, Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org, dev@linux-sunxi.org

--001a113d3c1e9cf582051f3e2a62
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 7 September 2015 at 15:02, Hans de Goede <hdegoede@redhat.com> wrote:
> Hi,
>
>
> On 06-09-15 16:47, Yousong Zhou wrote:
>>
>> On Sep 6, 2015 10:14 PM, "Shawn Lin" <shawn.lin@rock-chips.com> wrote:
>>>
>>>
>>> =E5=9C=A8 2015/9/6 20:09, Yousong Zhou =E5=86=99=E9=81=93:
>>>>
>>>>
>>>> Hi,
>>>>
>>>> On 6 September 2015 at 08:12, Shawn Lin <shawn.lin@rock-chips.com>
>>>> wrote:
>>>>>
>>>>>
>>>>> On 2015/9/5 22:58, Hans de Goede wrote:
>>>>>>
>>>>>>
>>>>>>
>>>>>> Hi Shawn Lin,
>>>>>>
>>>>>> On 05-09-15 16:07, Shawn Lin wrote:
>>>>>>>
>>>>>>>
>>>>>>>
>>>>>>> On 2015/9/5 18:19, Yousong Zhou wrote:
>>>>>>>>
>>>>>>>>
>>>>>>>>
>>>>>>>> A SD card with sunxi-mmc can fail with the following error message
>>>>>>>> (RCD for
>>>>>>>> response CRC error) when trying to switch to highspeed mode.
>>>>>>>> Setting
>>>>>>>> the bus
>>>>>>>> clock before the access mode switch fixed it.
>>>>>>>
>>>>>>>
>>>>>>>
>>>>>>>
>>>>>>> No, that's wrong!
>>>>>>>
>>>>>>> Before this card is switched to highspeed, it works under
>>>>>>> identification mode(From spec: bus clock <=3D 400KHz). How could yo=
u
>>>>>>> raise bus clock to higher clk rate which I _guess_ is 52MHz before
>>>>>>> you
>>>>>>> notify sd cards to run into highspeed mode?
>>>>>>>
>>>>>>> Althought it works for this card, this patch will not please the
>>>>>>> other
>>>>>>> cards that they might not reply CMDs any longer including the
>>>>>>> following CMD6.
>>>>>>
>>>>>>
>>>>>>
>>>>>>
>>>>>> Thanks for the feedback, this is exactly why I asked Yousong Zhou to
>>>>>> take this
>>>>>> to the mmc list.
>>>>>>
>>>>>> So if this is not the proper fix for the problem that Yousong Zhou i=
s
>>>>>> seeing, then
>>>>>> what might be the proper fix ?
>>>>>>
>>>>>
>>>>>   From my knowledge of mmc, there hadn't have a way to deal with this
>>
>> "broken"
>>>>>
>>>>> case. In another word, IMO,it's ANTI-SPEC. We can't be too spec
>>
>> sometimes,
>>>>>
>>>>> but at least we shouldn't violate it.
>>>>>
>>>>
>>>> Maybe the fix is anti-spec.  But the fact is that the card works on
>>>> many other platforms with the builtin card reader (not through an USB
>>>> adapter), including Mac OS X, my old Nokia Symbian phone, and Windows.
>>>>
>>>>>> Could it be that the sunxi-mmc is doing some things in the wrong ord=
er
>>>>>> when
>>>>>> changing the clock, or is this all under control of the mmc core ?
>>>>>>
>>>>>
>>>>> all of this is under control of the mmc core.
>>>>> So if Yongsong does want this card to work for any linux-based mmc
>>
>> stack, I
>>>>>
>>>>> guess something like that should be "better"?
>>>>>
>>>>> if (switch to HS fail) {
>>>>>           set_bus_clk
>>>>>           goto retry switch to HS
>>>>> }
>>>>>
>>>>> BUT...I admit it seems strange as well.
>>>>>
>>>>
>>>> The SD Specification (simplified version) says "If CRC error occurs on
>>>> the status data, the host should issue a power cycle.", so I guess the
>>>> above approach is anti-spec in some way :)
>>>>
>>>
>>> Right=EF=BC=8CI was guessing that way from your intention.
>>>
>>>
>>>> In case it may help debug this problem, I'd like to add that the card
>>>> previously worked fine with U-Boot before commit [1].  This can also
>>>> be confirmed by Debian Jessie installer image with which the old
>>>> U-Boot there worked fine while the kernel (3.16) did not.
>>>>
>>>>    [1] sunxi: mmc: Properly setup mod-clk and clock sampling phases,
>>>>
>>
>> http://git.denx.de/?p=3Du-boot.git;a=3Dcommit;h=3Dfc3a832576ce7bb597b182=
3935bfb7dcca235c3c
>
>
> Interesting, one thing that patch does is introduce a switch from parent =
pll
> when switching from 400KHz to higher clocks. Can you try the attached pat=
ch
> ?
>
> If reverting u-boot commit fc3a832576ce7bb597b1823935bfb7dcca235c3c fixes
> things, then it is probably best to focus on fixing u-boot first, and the=
n
> we can likely apply the same fix to the kernel.
>

I just tried a method from allwinner's u-boot sources: retry the mode switc=
h in
case of an error [1].  It was accompanied with a comment quoted below:

//retry for Toshiba emmc;for the first time Toshiba emmc change to HS
//it will return response crc err,so retry

Well, that 1GB card of mine is labeled as "pqi" made in Korea.  This workar=
ound
really worked and it succeeded on the second try, though I am not sure how
anti-spec this can be (the spec says a power reset SHOULD be done in the ca=
se
of crc error in the status data).

The above change alone can make the card work.  I also noticed that allwinn=
er's
uboot will disable the clock first before setting it and re-enable it
thereafter [2].  I can only guess that this is possibly some bugfix made
by engineers of allwinner.  So I mimicked this approach and attached a patc=
h
here.

 [1] https://github.com/allwinner-zh/bootloader/blob/master/u-boot-2011.09/=
drivers/mmc/mmc.c#L2220
 [2] https://github.com/allwinner-zh/bootloader/blob/master/u-boot-2011.09/=
drivers/mmc/sunxi_mmc.c#L822

Regards.

                yousong

> With which SoC(s) are you seeing this problem ? I believe that there
> may be some differences between the mmc controller used in the A10/13 vs
> later SoCs so this may be a SoC specific issue.
>
> Regards,
>
> Hans
>
>
>
>> OpenWrt ticket 20387 has more info about the U-Boot failure.
>>
>> https://dev.openwrt.org/ticket/20387
>>
>> Anyway, I have no idea what's the effect of those magic numbers on
>> "sampling phases".  Never played with such things before :)
>>
>>> I happended to fix some problems which seems *similar* to yours(but I'm
>>
>> not sure just from commit[1]'s msg):
>>>
>>>
>>> https://patchwork.kernel.org/patch/7119661/
>>>
>>>> Cheers
>>>>
>>>>                   yousong
>>>> --
>>>> To unsubscribe from this list: send the line "unsubscribe linux-mmc" i=
n
>>>> the body of a message to majordomo@vger.kernel.org
>>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>>>
>>>>
>>>>
>>>
>>>
>>> --
>>> Best Regards
>>> Shawn Lin
>>>
>>> --
>>> You received this message because you are subscribed to the Google Grou=
ps
>>
>> "linux-sunxi" group.
>>>
>>> To unsubscribe from this group and stop receiving emails from it, send =
an
>>
>> email to linux-sunxi+unsubscribe@googlegroups.com.
>>>
>>> For more options, visit https://groups.google.com/d/optout.
>>
>>
>

--001a113d3c1e9cf582051f3e2a62
Content-Type: application/octet-stream;
	name="0001-mmc-sunxi-split-setting-mod_clk-into-3-steps.patch"
Content-Disposition: attachment;
	filename="0001-mmc-sunxi-split-setting-mod_clk-into-3-steps.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_iebiv5qs1

RnJvbSA5MjZhNjhkZTkxNjE5Zjk1Mzk5ZTQ2MjFkNmIyZDU3YmQwY2Y5MWUwIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBZb3Vzb25nIFpob3UgPHlzemhvdTR0ZWNoQGdtYWlsLmNvbT4K
RGF0ZTogVHVlLCA4IFNlcCAyMDE1IDE0OjI0OjU4ICswODAwClN1YmplY3Q6IFtQQVRDSCAxLzJd
IG1tYzogc3VueGk6IHNwbGl0IHNldHRpbmcgbW9kX2NsayBpbnRvIDMgc3RlcHMKClNpZ25lZC1v
ZmYtYnk6IFlvdXNvbmcgWmhvdSA8eXN6aG91NHRlY2hAZ21haWwuY29tPgotLS0KIGRyaXZlcnMv
bW1jL3N1bnhpX21tYy5jIHwgICAxOCArKysrKysrKysrKysrKy0tLS0KIDEgZmlsZSBjaGFuZ2Vk
LCAxNCBpbnNlcnRpb25zKCspLCA0IGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMv
bW1jL3N1bnhpX21tYy5jIGIvZHJpdmVycy9tbWMvc3VueGlfbW1jLmMKaW5kZXggMjVmMThhZC4u
ZTkyYjRhNSAxMDA2NDQKLS0tIGEvZHJpdmVycy9tbWMvc3VueGlfbW1jLmMKKysrIGIvZHJpdmVy
cy9tbWMvc3VueGlfbW1jLmMKQEAgLTEzMywxNCArMTMzLDI0IEBAIHN0YXRpYyBpbnQgbW1jX3Nl
dF9tb2RfY2xrKHN0cnVjdCBzdW54aV9tbWNfaG9zdCAqbW1jaG9zdCwgdW5zaWduZWQgaW50IGh6
KQogCQlzY2xrX2RseSA9IDQ7CiAJfQogCi0Jd3JpdGVsKENDTV9NTUNfQ1RSTF9FTkFCTEUgfCBw
bGwgfCBDQ01fTU1DX0NUUkxfU0NMS19ETFkoc2Nsa19kbHkpIHwKLQkgICAgICAgQ0NNX01NQ19D
VFJMX04obikgfCBDQ01fTU1DX0NUUkxfT0NMS19ETFkob2Nsa19kbHkpIHwKLQkgICAgICAgQ0NN
X01NQ19DVFJMX00oZGl2KSwgbW1jaG9zdC0+bWNsa3JlZyk7Ci0KIAlkZWJ1ZygibW1jICV1IHNl
dCBtb2QtY2xrIHJlcSAldSBwYXJlbnQgJXUgbiAldSBtICV1IHJhdGUgJXVcbiIsCiAJICAgICAg
bW1jaG9zdC0+bW1jX25vLCBoeiwgcGxsX2h6LCAxdSA8PCBuLCBkaXYsCiAJICAgICAgcGxsX2h6
IC8gKDF1IDw8IG4pIC8gZGl2KTsKIAorCS8qIERpc2FibGUgbWNsayBmaXJzdCAqLworCXdyaXRl
bCgwLCBtbWNob3N0LT5tY2xrcmVnKTsKKwl1ZGVsYXkoNTAwKTsKKworCXdyaXRlbChwbGwgfCBD
Q01fTU1DX0NUUkxfU0NMS19ETFkoc2Nsa19kbHkpIHwgQ0NNX01NQ19DVFJMX04obikgfAorCSAg
ICAgICAgICAgICBDQ01fTU1DX0NUUkxfT0NMS19ETFkob2Nsa19kbHkpIHwgQ0NNX01NQ19DVFJM
X00oZGl2KSwKKwkgICAgICAgbW1jaG9zdC0+bWNsa3JlZyk7CisJdWRlbGF5KDUwMCk7CisKKwkv
KiBSZS1lbmFibGUgbWNsayAqLworCXdyaXRlbChDQ01fTU1DX0NUUkxfRU5BQkxFIHwgcmVhZGwo
bW1jaG9zdC0+bWNsa3JlZyksCisJICAgICAgIG1tY2hvc3QtPm1jbGtyZWcpOworCXVkZWxheSg1
MDApOworCiAJcmV0dXJuIDA7CiB9CiAKLS0gCjEuNy4xMC40Cgo=
--001a113d3c1e9cf582051f3e2a62
Content-Type: application/octet-stream;
	name="0002-mmc-retry-in-the-case-of-failing-to-switch-to-HS-mod.patch"
Content-Disposition: attachment;
	filename="0002-mmc-retry-in-the-case-of-failing-to-switch-to-HS-mod.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_iebiv5ry2

RnJvbSA0YmM2ZTVmNTU1YjMxN2IyZDVjMzgwMWZlN2ZiODkwNDE4M2M2MTU3IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBZb3Vzb25nIFpob3UgPHlzemhvdTR0ZWNoQGdtYWlsLmNvbT4K
RGF0ZTogU3VuLCAzMCBBdWcgMjAxNSAxNToyMTo0OSArMDgwMApTdWJqZWN0OiBbUEFUQ0ggMi8y
XSBtbWM6IHJldHJ5IGluIHRoZSBjYXNlIG9mIGZhaWxpbmcgdG8gc3dpdGNoIHRvIEhTIG1vZGUK
ClNpZ25lZC1vZmYtYnk6IFlvdXNvbmcgWmhvdSA8eXN6aG91NHRlY2hAZ21haWwuY29tPgotLS0K
IGRyaXZlcnMvbW1jL21tYy5jIHwgICAxNCArKysrKysrKysrKy0tLQogMSBmaWxlIGNoYW5nZWQs
IDExIGluc2VydGlvbnMoKyksIDMgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvZHJpdmVycy9t
bWMvbW1jLmMgYi9kcml2ZXJzL21tYy9tbWMuYwppbmRleCAzNzFjMWVjLi43ZWI5Mzc0IDEwMDY0
NAotLS0gYS9kcml2ZXJzL21tYy9tbWMuYworKysgYi9kcml2ZXJzL21tYy9tbWMuYwpAQCAtOTQ4
LDEwICs5NDgsMTggQEAgcmV0cnlfc2NyOgogCQkobW1jLT5jZmctPmhvc3RfY2FwcyAmIE1NQ19N
T0RFX0hTKSkpCiAJCXJldHVybiAwOwogCi0JZXJyID0gc2Rfc3dpdGNoKG1tYywgU0RfU1dJVENI
X1NXSVRDSCwgMCwgMSwgKHU4ICopc3dpdGNoX3N0YXR1cyk7CisJdGltZW91dCA9IDQ7CisJd2hp
bGUgKHRydWUpIHsKKwkJZXJyID0gc2Rfc3dpdGNoKG1tYywgU0RfU1dJVENIX1NXSVRDSCwgMCwg
MSwgKHU4ICopc3dpdGNoX3N0YXR1cyk7CisJCWlmICghZXJyKQorCQkJYnJlYWs7CiAKLQlpZiAo
ZXJyKQotCQlyZXR1cm4gZXJyOworCQl0aW1lb3V0IC09IDE7CisJCWlmICghdGltZW91dCkgewor
CQkJZGVidWcoInN3aXRjaGluZyB0byBoaWdoc3BlZWQgbW9kZSBmYWlsZWQ6ICVkXG4iLCBlcnIp
OworCQkJcmV0dXJuIGVycjsKKwkJfQorCX0KIAogCWlmICgoX19iZTMyX3RvX2NwdShzd2l0Y2hf
c3RhdHVzWzRdKSAmIDB4MGYwMDAwMDApID09IDB4MDEwMDAwMDApCiAJCW1tYy0+Y2FyZF9jYXBz
IHw9IE1NQ19NT0RFX0hTOwotLSAKMS43LjEwLjQKCg==
--001a113d3c1e9cf582051f3e2a62--
