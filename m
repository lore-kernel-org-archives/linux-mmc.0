From: Johan Rudholm <jrudholm@gmail.com>
Subject: Re: UHS-I voltage switching on OLPC XO-1.75
Date: Fri, 2 Nov 2012 15:35:22 +0100
Message-ID: <CA+20K0CQmFHNruQv5-7D=2kxqxp=Vt1h2rXXuKF0-JOm8jyoJQ@mail.gmail.com>
References: <CAMLZHHQfQ26E+BH2sqV9CGyso+uuKHC=WMaqehzBo9_Gr_kyPQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary=14dae9340f65b72a4004cd840bba
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-ia0-f174.google.com ([209.85.210.174]:43383 "EHLO
	mail-ia0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751441Ab2KBOfY (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 2 Nov 2012 10:35:24 -0400
Received: by mail-ia0-f174.google.com with SMTP id y32so2687334iag.19
        for <linux-mmc@vger.kernel.org>; Fri, 02 Nov 2012 07:35:23 -0700 (PDT)
In-Reply-To: <CAMLZHHQfQ26E+BH2sqV9CGyso+uuKHC=WMaqehzBo9_Gr_kyPQ@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Daniel Drake <dsd@laptop.org>
Cc: Chris Ball <cjb@laptop.org>, linux-mmc@vger.kernel.org

--14dae9340f65b72a4004cd840bba
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

Hi Daniel,

2012/10/30 Daniel Drake <dsd@laptop.org>:
> Hi,
>
> Following on from the recent thread
>   [PATCH 2/2] mmc: core: Power cycle card on voltage switch fail
> I have tried to get a better grip on the problems being faced.
>
> Test setup:
> OLPC XO-1.75 laptop, based on Marvell MMP2 ARM SoC (includes sdhci-pxa
> interface)
> 32GB Sandisk Ultra SD card being inserted into external SD slot
>
> The SoC apparently has support for 1.8V, but we physically do not have
> the right power lines wired on the motherboard, so we need to detect
> the 1.8V failure and go back to 3.3V mode.

An initial question, would it be possible to solve this by disabling
the UHS support in the host cap, or through a quirk? Maybe this kind
of solution is not applicable in this scenario? I wonder this because
I guess it will be very hard to know how a card will react if we first
tell it that we're going to switch voltages and then don't, since this
is out of spec.

> I tracked down what causes this regression. In order to get the
> failure detection working again, I have to make the following change
> in mmc_set_signal_voltage():
>                 if (cmd11) {
>                         host->ios.clock =3D 0;
> -                       mmc_set_ios(host);
> +                       //mmc_set_ios(host);
>                 }
> (i.e. don't mess with ios before asking sdhci to do the voltage switch)
>
> and at the top of sdhci_do_1_8v_signal_voltage_switch:
> +       /* Stop SDCLK */
> +       clk =3D sdhci_readw(host, SDHCI_CLOCK_CONTROL);
> +       clk &=3D ~SDHCI_CLOCK_CARD_EN;
> +       sdhci_writew(host, clk, SDHCI_CLOCK_CONTROL);
> (i.e. add the equivalent clock disabling code here)

Ok, so this suggests that the SDHCI driver does not stop the clock
when we set ios.clock =3D 0 and call mmc_set_ios?

> With that change, I now get:
>   mmc2: Signal voltage switch failed, power cycling card (retries =3D 10)
>   mmc2: error -110 whilst initialising SD card
>
> The -110 error comes from mmc_send_app_op_cond(), but its worth noting
> that mmc_send_if_cond() (called immediately above) silently failed
> with -110 too. Neither of these failed the first time around before
> 1.8V was tried.
>
> Full patch that I'm testing with: http://dev.laptop.org/~dsd/20121030/mmc=
.patch
>
> So, now the question is: why is the card not responding to
> if_cond/app_op_cond after being powered down and up again? Is the
> power down/up sequence OK?

Good question. I=92d guess that mmc_power_off/up does not work as
expected here, that the card is not at all power cycled. But it seems
that the power cycle code in sdhci_do_start_signal_voltage_switch
works? What if we export a couple of debug functions from sdhci.c
which allow us to power cycle and control the clock just like sdhci
does, and call these functions from core.c and sd.c? If this works
(and the failure is detected properly by the core layer, and 10
retries are made etc), then we know that the problems most likely
depend on how mmc_set_ios and mmc_power_off/up work with sdhci. I've
attached a patch suggesting this, if you'd like to give it a try
(warning: the patch has not been tested). The patch does not do
anything about pm_runtime, but perhaps we don't need to worry about
this here.

> I tried inserting the mmc_power_off, mmc_power_up, mmc_send_if_cond
> sequence into various points in the codepaths being discussed.
> Measuring success as the card responding to mmc_send_if_cond(0x30080)
> without error (0x30080 is a known good value from when before 1.8V is
> tried), I find that this "reset sequence" works just fine up until the
> point when CMD11 is run.
> CMD11 is sent and returns successfully without error, but from this
> point, running the reset sequence will fail (send_if_cond will fail
> with -110).
>
> Is this kind of test valid? Does this suggest that something is wrong
> with the host controller hardware? My assumption is that whatever
> state is modified by CMD11 should be erased here, and of course the
> hope is that mmc_power_off and mmc_power_up will do a full power cycle
> anyway. But whatever is happening, it looks like the effects of CMD11
> are persisting past the reset sequence and are breaking later
> communication.

I think that the power cycle has simply failed here, I find it hard to
believe that CMD11 has persistent effects :) If mmc_power_off/up
actually works, then perhaps the 1ms udelay is too small for this
case?

Kind regards, Johan

--14dae9340f65b72a4004cd840bba
Content-Type: application/octet-stream;
	name="0001-Clock-and-power-control.patch"
Content-Disposition: attachment;
	filename="0001-Clock-and-power-control.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_h91efgbt0

RnJvbSBhNTIxZGU0ZTUxOTZiZGI0YjgxYzgyNWQ1ZmYzODQxNTEzZTkyODY5IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBKb2hhbiBSdWRob2xtIDxqb2hhbi5ydWRob2xtQHN0ZXJpY3Nz
b24uY29tPgpEYXRlOiBGcmksIDIgTm92IDIwMTIgMTU6MjI6MTcgKzAxMDAKU3ViamVjdDogW1BB
VENIXSBDbG9jayBhbmQgcG93ZXIgY29udHJvbAoKLS0tCiBkcml2ZXJzL21tYy9jb3JlL2NvcmUu
YyAgfCAgIDExICsrKysrLS0tLS0tCiBkcml2ZXJzL21tYy9jb3JlL3NkLmMgICAgfCAgICA2ICsr
LS0tLQogZHJpdmVycy9tbWMvaG9zdC9zZGhjaS5jIHwgICAzMiArKysrKysrKysrKysrKysrKysr
KysrKysrKysrKysrKwogMyBmaWxlcyBjaGFuZ2VkLCAzOSBpbnNlcnRpb25zKCspLCAxMCBkZWxl
dGlvbnMoLSkKCmRpZmYgLS1naXQgYS9kcml2ZXJzL21tYy9jb3JlL2NvcmUuYyBiL2RyaXZlcnMv
bW1jL2NvcmUvY29yZS5jCmluZGV4IGRjZmQ0NTEuLmUxZTc5N2EgMTAwNjQ0Ci0tLSBhL2RyaXZl
cnMvbW1jL2NvcmUvY29yZS5jCisrKyBiL2RyaXZlcnMvbW1jL2NvcmUvY29yZS5jCkBAIC0xMDQ0
LDYgKzEwNDQsOCBAQCB1MzIgbW1jX3NlbGVjdF92b2x0YWdlKHN0cnVjdCBtbWNfaG9zdCAqaG9z
dCwgdTMyIG9jcikKIAlyZXR1cm4gb2NyOwogfQogCitleHRlcm4gdm9pZCBjbG9ja19jb250cm9s
KHN0cnVjdCBtbWNfaG9zdCAqbW1jLCBpbnQgb24pOworCiBpbnQgbW1jX3NldF9zaWduYWxfdm9s
dGFnZShzdHJ1Y3QgbW1jX2hvc3QgKmhvc3QsIGludCBzaWduYWxfdm9sdGFnZSwgYm9vbCBjbWQx
MSkKIHsKIAlzdHJ1Y3QgbW1jX2NvbW1hbmQgY21kID0gezB9OwpAQCAtMTA3NiwyMCArMTA3OCwx
NyBAQCBpbnQgbW1jX3NldF9zaWduYWxfdm9sdGFnZShzdHJ1Y3QgbW1jX2hvc3QgKmhvc3QsIGlu
dCBzaWduYWxfdm9sdGFnZSwgYm9vbCBjbWQxMQogCQltbWNfaG9zdF9jbGtfaG9sZChob3N0KTsK
IAkJY2xvY2sgPSBob3N0LT5pb3MuY2xvY2s7CiAJCWlmIChjbWQxMSkgewotCQkJaG9zdC0+aW9z
LmNsb2NrID0gMDsKLQkJCW1tY19zZXRfaW9zKGhvc3QpOworCQkJY2xvY2tfY29udHJvbChob3N0
LCAwKTsKIAkJfQogCiAJCWVyciA9IGhvc3QtPm9wcy0+c3RhcnRfc2lnbmFsX3ZvbHRhZ2Vfc3dp
dGNoKGhvc3QsICZob3N0LT5pb3MpOwogCiAJCWlmIChlcnIgJiYgY21kMTEpIHsKLQkJCWhvc3Qt
Pmlvcy5jbG9jayA9IGNsb2NrOwotCQkJbW1jX3NldF9pb3MoaG9zdCk7CisJCQljbG9ja19jb250
cm9sKGhvc3QsIDEpOwogCQl9IGVsc2UgaWYgKGNtZDExKSB7CiAJCQkvKiBTdG9wIGNsb2NrIGZv
ciBhdCBsZWFzdCA1IG1zIGFjY29yZGluZyB0byBzcGVjICovCiAJCQltbWNfZGVsYXkoNSk7Ci0J
CQlob3N0LT5pb3MuY2xvY2sgPSBjbG9jazsKLQkJCW1tY19zZXRfaW9zKGhvc3QpOworCQkJY2xv
Y2tfY29udHJvbChob3N0LCAxKTsKIAogCQkJLyogV2FpdCBmb3IgYXQgbGVhc3QgMSBtcyBhY2Nv
cmRpbmcgdG8gc3BlYyAqLwogCQkJbW1jX2RlbGF5KDEpOwpkaWZmIC0tZ2l0IGEvZHJpdmVycy9t
bWMvY29yZS9zZC5jIGIvZHJpdmVycy9tbWMvY29yZS9zZC5jCmluZGV4IGRkNDUwOWYuLjg1MjNj
NGYgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvbW1jL2NvcmUvc2QuYworKysgYi9kcml2ZXJzL21tYy9j
b3JlL3NkLmMKQEAgLTcyMCw2ICs3MjAsNyBAQCBzdHJ1Y3QgZGV2aWNlX3R5cGUgc2RfdHlwZSA9
IHsKIAkuZ3JvdXBzID0gc2RfYXR0cl9ncm91cHMsCiB9OwogCitleHRlcm4gdm9pZCBwb3dlcl9j
eWNsZShzdHJ1Y3QgbW1jX2hvc3QgKm1tYyk7CiAvKgogICogRmV0Y2ggQ0lEIGZyb20gY2FyZC4K
ICAqLwpAQCAtNzgzLDEwICs3ODQsNyBAQCB0cnlfYWdhaW46CiAJCQlwcl93YXJuaW5nKCIlczog
U2lnbmFsIHZvbHRhZ2Ugc3dpdGNoIGZhaWxlZCwgIgogCQkJCSJwb3dlciBjeWNsaW5nIGNhcmQg
KHJldHJpZXMgPSAlZClcbiIsCiAJCQkJbW1jX2hvc3RuYW1lKGhvc3QpLCByZXRyaWVzKTsKLQkJ
CW1tY19wb3dlcl9vZmYoaG9zdCk7Ci0JCQkvKiBXYWl0IGF0IGxlYXN0IDEgbXMgYWNjb3JkaW5n
IHRvIHNwZWMgKi8KLQkJCW1tY19kZWxheSgxKTsKLQkJCW1tY19wb3dlcl91cChob3N0KTsKKwkJ
CXBvd2VyX2N5Y2xlKGhvc3QpOwogCQkJcmV0cmllcy0tOwogCQkJZ290byB0cnlfYWdhaW47CiAJ
CX0gZWxzZSBpZiAoZXJyKSB7CmRpZmYgLS1naXQgYS9kcml2ZXJzL21tYy9ob3N0L3NkaGNpLmMg
Yi9kcml2ZXJzL21tYy9ob3N0L3NkaGNpLmMKaW5kZXggZjRiOGI0ZC4uYmMyOWEwNCAxMDA2NDQK
LS0tIGEvZHJpdmVycy9tbWMvaG9zdC9zZGhjaS5jCisrKyBiL2RyaXZlcnMvbW1jL2hvc3Qvc2Ro
Y2kuYwpAQCAtMTY3Nyw2ICsxNjc3LDM4IEBAIHN0YXRpYyBpbnQgc2RoY2lfZG9fc3RhcnRfc2ln
bmFsX3ZvbHRhZ2Vfc3dpdGNoKHN0cnVjdCBzZGhjaV9ob3N0ICpob3N0LAogCQlyZXR1cm4gMDsK
IH0KIAordm9pZCBwb3dlcl9jeWNsZShzdHJ1Y3QgbW1jX2hvc3QgKm1tYykKK3sKKwlzdHJ1Y3Qg
c2RoY2lfaG9zdCAqaG9zdCA9IG1tY19wcml2KG1tYyk7CisJdTggcHdyOworCisJcHdyID0gc2Ro
Y2lfcmVhZGIoaG9zdCwgU0RIQ0lfUE9XRVJfQ09OVFJPTCk7CisJcHdyICY9IH5TREhDSV9QT1dF
Ul9PTjsKKwlzZGhjaV93cml0ZWIoaG9zdCwgcHdyLCBTREhDSV9QT1dFUl9DT05UUk9MKTsKKwor
CS8qIFdhaXQgZm9yIDFtcyBhcyBwZXIgdGhlIHNwZWMgKi8KKwl1c2xlZXBfcmFuZ2UoMTAwMCwg
MTUwMCk7CisJcHdyIHw9IFNESENJX1BPV0VSX09OOworCXNkaGNpX3dyaXRlYihob3N0LCBwd3Is
IFNESENJX1BPV0VSX0NPTlRST0wpOworfQorCit2b2lkIGNsb2NrX2NvbnRyb2woc3RydWN0IG1t
Y19ob3N0ICptbWMsIGludCBvbikKK3sKKwlzdHJ1Y3Qgc2RoY2lfaG9zdCAqaG9zdCA9IG1tY19w
cml2KG1tYyk7CisJdTE2IGNsazsKKworCWlmIChvbikgeworCQljbGsgPSBzZGhjaV9yZWFkdyho
b3N0LCBTREhDSV9DTE9DS19DT05UUk9MKTsKKwkJY2xrIHw9IFNESENJX0NMT0NLX0NBUkRfRU47
CisJCXNkaGNpX3dyaXRldyhob3N0LCBjbGssIFNESENJX0NMT0NLX0NPTlRST0wpOworCX0gZWxz
ZSB7CisJCS8qIFN0b3AgU0RDTEsgKi8KKwkJY2xrID0gc2RoY2lfcmVhZHcoaG9zdCwgU0RIQ0lf
Q0xPQ0tfQ09OVFJPTCk7CisJCWNsayAmPSB+U0RIQ0lfQ0xPQ0tfQ0FSRF9FTjsKKwkJc2RoY2lf
d3JpdGV3KGhvc3QsIGNsaywgU0RIQ0lfQ0xPQ0tfQ09OVFJPTCk7CisJfQorfQorCiBzdGF0aWMg
aW50IHNkaGNpX3N0YXJ0X3NpZ25hbF92b2x0YWdlX3N3aXRjaChzdHJ1Y3QgbW1jX2hvc3QgKm1t
YywKIAlzdHJ1Y3QgbW1jX2lvcyAqaW9zKQogewotLSAKMS43LjEwCgo=
--14dae9340f65b72a4004cd840bba--
